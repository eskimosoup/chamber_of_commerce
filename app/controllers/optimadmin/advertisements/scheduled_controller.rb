module Optimadmin
  module Advertisements
    class ScheduledController < Optimadmin::AdvertisementsController
      def index
        @advertisements = @all_items.scheduled
                                    .pagination(params[:page], params[:per_page])
      end
    end
  end
end
