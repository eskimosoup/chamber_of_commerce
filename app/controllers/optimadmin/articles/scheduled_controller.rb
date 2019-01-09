module Optimadmin
  module Articles
    class ScheduledController < Optimadmin::ArticlesController
      def index
        @articles = @all_items.scheduled
                                    .pagination(params[:page], params[:per_page])
      end
    end
  end
end
