module Optimadmin
  module Articles
    class ExpiredController < Optimadmin::ArticlesController
      def index
        @articles = @all_items.expired
                                    .pagination(params[:page], params[:per_page])
      end
    end
  end
end
