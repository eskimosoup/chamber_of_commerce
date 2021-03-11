# frozen_string_literal: true

#
# Obfuscate ids
#
module ObfuscateIds
  extend ActiveSupport::Concern

  # @return [string] Unique SALT
  MY_SALT = 'C5DENGtXnwCqank'

  included do
    after_create :save_hashed_id

    #
    # Allow uniue hash to be used for links and params
    #
    # @return [string]
    #
    def to_param
      hashed_id
    end
  end

  #
  # Save hash
  #
  # @param [symbol] column
  #
  # @return [boolean]
  #
  def save_hashed_id(column = :hashed_id)
    update_column(column, generate_hashed_id(column))
  end

  #
  # Generate a unique hash
  #
  # @param [symbol] column
  # @param [integer] length
  #
  # @return [string]
  #
  def generate_hashed_id(column, length = 3)
    self[column] = Digest::SHA1.hexdigest(hashable_string)[0..length]
    generate_hashed_id(column, length + 1) if self.class.exists?(column => self[column])
    self[column]
  end

  private

  #
  # Hashable string
  #
  # @return [string]
  #
  def hashable_string
    [MY_SALT, id, SecureRandom.hex(8), created_at.to_i, self.class.name].join
  end
end
