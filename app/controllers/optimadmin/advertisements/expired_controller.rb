module Optimadmin
  module Advertisements
    class ExpiredController < Optimadmin::AdvertisementsController
      def index
        @advertisements = @all_items.expired
                                    .pagination(params[:page], params[:per_page])
      end
    end
  end
end
