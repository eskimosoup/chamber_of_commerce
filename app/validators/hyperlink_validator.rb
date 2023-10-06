# @see https://stackoverflow.com/questions/7167895/rails-whats-a-good-way-to-validate-links-urls
class HyperlinkValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && uri.host.present?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    unless value.present? && self.class.compliant?(value)
      record.errors.add(attribute, 'is not a valid HTTP URL')
    end
  end
end
