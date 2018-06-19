module Optimadmin
  module Advertisements
    class PublishedController < Optimadmin::AdvertisementsController
      def index
        @advertisements = @all_items.published
                                    .pagination(params[:page], params[:per_page])
      end
    end
  end
end
