# frozen_string_literal: true

module Memberships
  class GroupUploader < Optimadmin::ImageUploader
    CROPS = {
      index: ['fill', 150, 150],
      show: ['fill', 640, 250]
    }.freeze
    public_constant :CROPS

    version :index do
      process resize_to_fill: CROPS[:index].drop(1)
    end

    version :show do
      process resize_to_fill: CROPS[:show].drop(1)
    end
  end
end
