class MagazinesController < ApplicationController
  def index
    @additional_content = AdditionalContentPresenter.new(object: AdditionalContent.find_by(area: 'Magazines - Index'), view_template: view_context)
    @magazines = Optimadmin::BaseCollectionPresenter.new(collection: Magazine.where("date <= ? and display = ?", Date.today, true).order(date: :desc).page(params[:page]).per(6), view_template: view_context, presenter: MagazinePresenter)
  end
end
