module Optimadmin
  class MembersController < Optimadmin::ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    def index
      @members = Optimadmin::BaseCollectionPresenter.new(collection: Member.includes(:member_login).where('company_name ILIKE ?', "%#{params[:search]}%").reorder(:company_name).page(params[:page]).per(params[:per_page] || 15).order(params[:order]), view_template: view_context, presenter: Optimadmin::MemberPresenter)
    end

    def logins_only
      @members = Optimadmin::BaseCollectionPresenter.new(collection: Member.includes(:member_login).where('company_name ILIKE ? AND id IN (?)', "%#{params[:search]}%", MemberLogin.all.pluck(:member_id)).page(params[:page]).per(params[:per_page] || 15).order(params[:order]), view_template: view_context, presenter: Optimadmin::MemberPresenter)
    end

    def new
      @member = Member.new
    end

    def edit
    end

    def create
      @member = Member.new(member_params)
      if @member.save
        redirect_to_index_or_continue_editing(@member)
      else
        render :new
      end
    end

    def update
      if @member.update(member_params)
        redirect_to_index_or_continue_editing(@member)
      else
        render :edit
      end
    end

    def destroy
      @member.destroy
      redirect_to members_url, notice: 'Member was successfully destroyed.'
    end

    def import_csv
      @member_import = Member::Import.new
      @members = Optimadmin::BaseCollectionPresenter.new(collection: Member.unscoped.includes(:member_login).where(in_csv: false).order("LOWER(company_name)").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::MemberPresenter)
      @members_with_logins = Optimadmin::BaseCollectionPresenter.new(collection: Member.unscoped.includes(:member_login).where(in_csv: false, id: MemberLogin.all.pluck(:member_id)).order("LOWER(company_name)").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::MemberPresenter)
    end

    def import
      @member_import = Member::Import.new(member_import_params)
      if @member_import.save
        redirect_to import_csv_members_path, notice: "#{ @member_import.imported_count } records imported, #{ @member_import.updated_count } records updated"
      else
        render :import_csv, notice: "There were errors with your CSV file"
      end
    end

    def destroy_non_csv_members
      @members = Member.unscoped.includes(:member_login).where(in_csv: false)
      # @message = "#{@members.size} member(s) were successfully destroyed."
      # @members.destroy_all
      redirect_to import_csv_members_path #, notice: @message
    end

  private


    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:company_name, :industry, :address, :telephone, :website, :email, :verified, :nature_of_business, :in_csv, :chamber_db_id, :post_code)
    end

    def member_import_params
      params.require(:member_import).permit(:file)
    end
  end
end
