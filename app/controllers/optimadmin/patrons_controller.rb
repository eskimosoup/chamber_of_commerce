module Optimadmin
  class PatronsController < Optimadmin::ApplicationController
    before_action :set_patron, only: [:show, :edit, :update, :destroy]

    edit_images_for Patron, [[:image, { show: ['fill', 118, 60] }]]

    def index
      @patrons = Patron.where('name ILIKE ?', "#{params[:search]}%").order(position: :asc).map{|x| Optimadmin::PatronPresenter.new(object: x, view_template: view_context) }
    end

    def show
    end

    def new
      @patron = Patron.new
    end

    def edit
    end

    def create
      @patron = Patron.new(patron_params)
      if @patron.save
        redirect_to patrons_url, notice: 'Patron was successfully created.'
      else
        render :new
      end
    end

    def update
      if @patron.update(patron_params)
        redirect_to patrons_url, notice: 'Patron was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @patron.destroy
      redirect_to patrons_url, notice: 'Patron was successfully destroyed.'
    end

  private


    def set_patron
      @patron = Patron.find(params[:id])
    end

    def patron_params
      params.require(:patron).permit(:name, :image, :image_cache, :remove_image, :link, :display)
    end
  end
end
