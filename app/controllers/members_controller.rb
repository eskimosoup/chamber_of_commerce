class MembersController < ApplicationController
  before_action :members_only, only: [:edit, :update]

  def index
  end

  def show
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    @member.assign_attributes(member_params)
    if @member.valid?
      MemberMailer.update_details(global_site_settings, current_member, @member).deliver_now
      redirect_to edit_members_path, notice: 'Request sent successfully'
    else
      render :edit
    end
  end

  private

    def member_params
      params.require(:member).permit(:company_name, :industry, :address, :telephone, :website, :email, :verified, :nature_of_business)
    end
end
