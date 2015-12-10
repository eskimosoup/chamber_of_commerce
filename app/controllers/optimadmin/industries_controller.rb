module Optimadmin
  class IndustriesController < Optimadmin::ApplicationController
    before_action :set_industry, only: [:show, :edit, :update, :destroy]

    def index
      @industries = Optimadmin::BaseCollectionPresenter.new(collection: Industry.where('name ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::IndustryPresenter)
    end

    def show
    end

    def new
      @industry = Industry.new
    end

    def edit
    end

    def create
      @industry = Industry.new(industry_params)
      if @industry.save
        redirect_to_index_or_continue_editing(@industry)
      else
        render :new
      end
    end

    def update
      if @industry.update(industry_params)
        redirect_to_index_or_continue_editing(@industry)
      else
        render :edit
      end
    end

    def destroy
      @industry.destroy
      redirect_to industries_url, notice: 'Industry was successfully destroyed.'
    end

    def import_csv
      @industry_import = Industry::Import.new
    end

    def import
      @industry_import = Industry::Import.new(industry_import_params)
      if @industry_import.save
        redirect_to industries_path, notice: "#{ @industry_import.imported_count } records imported, #{ @industry_import.updated_count } records updated"
      else
        render :import_csv, notice: "There were errors with your CSV file"
      end
    end

  private

    def set_industry
      @industry = Industry.find(params[:id])
    end

    def industry_params
      params.require(:industry).permit(:name)
    end

    def industry_import_params
      params.require(:industry_import).permit(:file)
    end
  end
end
