module Optimadmin
  class MembersController < Optimadmin::ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    def index
      @members = Optimadmin::BaseCollectionPresenter.new(collection: Member.where('company_name ILIKE ?', "#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::MemberPresenter)
    end

    def new
      @member = Member.new
    end

    def edit
    end

    def create
      @member = Member.new(member_params)
      if @member.save
        redirect_to members_url, notice: 'Member was successfully created.'
      else
        render :new
      end
    end

    def update
      if @member.update(member_params)
        redirect_to members_url, notice: 'Member was successfully updated.'
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
    end

    def import
      @member_import = Member::Import.new(member_import_params)
      if @member_import.save
        redirect_to members_path, notice: "#{ @member_import.imported_count } records imported, #{ @member_import.updated_count } records updated"
      else
        render :import_csv, notice: "There were errors with your CSV file"
      end
    end

  private


    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:company_name, :industry, :address, :telephone, :website, :email, :verified, :nature_of_business)
    end

    def member_import_params
      params.require(:member_import).permit(:file)
    end
  end
end
