module Optimadmin
  class Memberships::GroupsController < ::Optimadmin::BaseController
    before_action :set_group, only: %i[show edit update destroy]

    edit_images_for ::Memberships::Group,
                    [
                      [:image, ::Memberships::GroupUploader::CROPS]
                    ]

    def index
      @groups = ::Memberships::Group.field_order(params[:order] || 'position')
                                    .field_search(params[:search])
                                    .pagination(params[:page], params[:per_page])
    end

    def show; end

    def new
      @group = ::Memberships::Group.new
    end

    def edit; end

    def create
      @group = ::Memberships::Group.new(memberships_group_params)
      if @group.save
        redirect_to_index_or_continue_editing(@group)
      else
        render(:new)
      end
    end

    def update
      if @group.update(memberships_group_params)
        redirect_to_index_or_continue_editing(@group)
      else
        render(:edit)
      end
    end

    def destroy
      if @group.destroy
        redirect_back(fallback_location: { action: :index }, notice: t('optimadmin.controllers.module.destroy', model_name: ::Memberships::Group.model_name.human))
      else
        redirect_back(fallback_location: { action: :index }, flash: { error: @group.errors.messages[:base].first })
      end
    end

    private

    def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
      redirect_to(fallback_location, notice: (flash.present? ? flash[:error] : notice))
    end

    def set_group
      @group = ::Memberships::Group.find(params[:id])
    end

    def memberships_group_params
      params.require(:memberships_group).permit(
        :position,
        :title,
        :summary,
        :content,
        :image,
        :display,
        :remove_image,
        :remote_image_url,
        :image_cache
      )
    end
  end
end
