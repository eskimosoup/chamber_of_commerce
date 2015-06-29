module Optimadmin
  class PatronsController < Optimadmin::ApplicationController
    before_action :set_patron, only: [:show, :edit, :update, :destroy]

    def index
      @patrons = Patron.page(params[:page]).per(15)
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
        redirect_to @patron, notice: 'Patron was successfully created.'
      else
        render :new
      end
    end

    def update
      if @patron.update(patron_params)
        redirect_to @patron, notice: 'Patron was successfully updated.'
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
      @patron = @patron.find(params[:id])
    end

    def patron_params
      params.require(:patron).permit(:name, :image, :link, :display)
    end
  end
end