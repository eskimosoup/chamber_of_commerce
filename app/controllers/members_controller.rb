class MembersController < ApplicationController
  before_action :members_only, only: [:edit, :update]
  before_action :set_member, only: :show

  def index
    @additional_content = AdditionalContentPresenter.new(object: AdditionalContent.find_by(area: 'Members - Index'), view_template: view_context)
    search_query = Member.filter(params.slice(:company_name, :search_terms)).page(params[:page]).per(params[:per_page] || 15).group('members.id').order("LOWER(company_name)")
    @presented_members = BaseCollectionPresenter.new(collection: search_query,
                                                    view_template: view_context, presenter: MemberPresenter)
  end

  def show
    redirect_to @member_object, status: :moved_permanently if request.path != member_path(@member_object)
  end

  def directory
    @additional_content = AdditionalContentPresenter.new(object: AdditionalContent.find_by(area: 'Members - Directroy'), view_template: view_context)
    @presented_members = Member.order("LOWER(company_name)").group_by{|x| x.company_name.titleize.first}
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    @member.assign_attributes(member_params)
    if @member.valid?
      MemberMailer.update_details(global_site_settings, current_member, @member).deliver_now
      redirect_to edit_members_url, notice: 'Request sent successfully'
    else
      render :edit
    end
  end

  private
    def set_member
      @member_object = Member.find(params[:id])
      @presented_member = MemberPresenter.new(object: @member_object, view_template: view_context)
    end

    def member_params
      params.require(:member).permit(:company_name, :industry, :address, :telephone, :website, :email, :verified, :nature_of_business)
    end
end
