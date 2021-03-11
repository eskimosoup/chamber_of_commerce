# == Schema Information
#
# Table name: memberships_groups
#
#  id            :integer          not null, primary key
#  content       :text
#  display       :boolean          default(TRUE)
#  image         :string
#  position      :integer          default(0)
#  slug          :string
#  suggested_url :string
#  summary       :text
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_memberships_groups_on_slug  (slug)
#
module Memberships
  class Group < ActiveRecord::Base
    include OptimadminScopes
    include MenuResourceable
    extend FriendlyId

    friendly_id :slug_candidates, use: %i[slugged history]

    mount_uploader :image, Memberships::GroupUploader

    scope :ordered, -> { order(:position) }
    scope :displayed, -> { where(display: true) }

    validates :title, presence: true

    def slug_candidates
      [
        :suggested_url,
        :title,
        %i[suggested_url title]
      ]
    end

    def should_generate_new_friendly_id?
      slug.blank? || suggested_url_changed? || title_changed?
    end
  end
end
