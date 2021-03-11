# frozen_string_literal: true

#
# Additional contentable helper
#
module AdditionalContentable
  extend ActiveSupport::Concern

  included do
    #
    # Additional content
    #
    # @return [object]
    #
    def additional_content
      @additional_content ||= AdditionalContent.find_by(area: additional_content_key)
    end

    #
    # Additional content?
    #
    # @return [boolean]
    #
    def additional_content?
      additional_content_key_defined? && additional_content.present?
    end
  end

  #
  # Additional content key defined check
  #
  # @return [boolean]
  #
  def additional_content_key_defined?
    return true if additional_content_key_exists?

    if Rails.env.development?
      raise AdditionalContentKeyNotDefined,
            "Key not defined in AdditionalContent: '#{additional_content_key}'"
    end
  end

  #
  # Additional content key exists check
  #
  # @return [boolean]
  #
  def additional_content_key_exists?
    ::AdditionalContent::AREAS.include?(additional_content_key)
  end

  #
  # Additional content key
  #
  # @return [string]
  #
  def additional_content_key
    [additional_content_namespace, additional_content_class].join(' - ')
  end

  #
  # Additional content namespace
  #
  # @return [string]
  #
  def additional_content_namespace
    self.class.name.split('::')[0..-2].map do |x|
      x.underscore.humanize.titleize
    end.join('/')
  end

  #
  # Additional content class
  #
  # @return [string]
  #
  def additional_content_class
    self.class.name.demodulize.gsub('Facade', '').to_s
  end

  #
  # Additional content key not defined error
  #
  class AdditionalContentKeyNotDefined < StandardError
  end
end
