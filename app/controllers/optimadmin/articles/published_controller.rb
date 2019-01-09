module Optimadmin
  module Articles
    class PublishedController < Optimadmin::ArticlesController
      def index
        @articles = @all_items.published
                                    .pagination(params[:page], params[:per_page])
      end
    end
  end
end
