module Memberships
  class BaseController < ApplicationController
    private

    #
    # Determine if slug is correct for rendering, etc. - prevent double redirect
    #
    # @param [object] object
    #
    # @return [boolean]
    #
    def correct_slug?(object)
      object.slug == params[:id]
    end

    #
    # Redirect to slug
    #
    # @param [object] object
    # @param [symbol] action
    #
    # @return [mixed] redirect or nil
    #
    def redirect_to_slug(object, action: :show)
      unless correct_slug?(object)
        redirect_to(
          { action: action, id: object.slug },
          status: :moved_permanently
        )
      end
    rescue StandardError
      nil
    end
  end
end
