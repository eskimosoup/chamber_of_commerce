class PagesController < ApplicationController
  def show
    @page_object = Page.where(display: true).find(params[:id])
    @page = PagePresenter.new(object: @page_object, view_template: view_context)
    if request.path != page_path(@page_object)
      return redirect_to @page_object, status: :moved_permanently
    end
  end
end
