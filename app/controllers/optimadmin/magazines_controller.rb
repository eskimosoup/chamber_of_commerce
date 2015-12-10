module Optimadmin
  class MagazinesController < Optimadmin::ApplicationController
    before_action :set_magazine, only: [:show, :edit, :update, :destroy]

    edit_images_for Magazine, [[:image, { show: ['limit', 162, 216] }]]

    def index
      @magazines = Optimadmin::BaseCollectionPresenter.new(collection: Magazine.where('name ILIKE ?', "%#{params[:search]}%").order(date: :desc).page(params[:page]).per(25), view_template: view_context, presenter: Optimadmin::MagazinePresenter)
    end

    def show
    end

    def new
      @magazine = Magazine.new
    end

    def edit
    end

    def create
      @magazine = Magazine.new(magazine_params)
      if @magazine.save
        redirect_to_index_or_continue_editing(@magazine)
      else
        render :new
      end
    end

    def update
      if @magazine.update(magazine_params)
        redirect_to_index_or_continue_editing(@magazine)
      else
        render :edit
      end
    end

    def destroy
      @magazine.destroy
      redirect_to magazines_url, notice: 'Magazine was successfully destroyed.'
    end

  private


    def set_magazine
      @magazine = Magazine.find(params[:id])
    end

    def magazine_params
      params.require(:magazine).permit(:name, :file, :date, :image, :image_cache, :remove_image, :remote_image_url, :display)
    end
  end
end
