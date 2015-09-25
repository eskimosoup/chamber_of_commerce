class EventBookingPresenter < BasePresenter
  presents :event_booking

  delegate :nature_of_business, :phone_number, :forename, :surname, :company_name, :industry, :email, :price, :stripe_price,
           :address_line_1, :address_line_2, :town, :postcode, to: :event_booking

  def name
    [forename, surname].compact.join(" ")
  end

  def company_name
    return nil unless event_booking.company_name
    two_column_row(first_column_content: "Company Name", second_column_content: event_booking.company_name)
  end

  def address
    return nil unless address_fields.blank?
    two_column_row(first_column_content: "Address", second_column_content: h.simple_format(address_fields.compact.join("\n")))
  end

  def industry
    return nil unless event_booking.industry
    two_column_row(first_column_content: "Industry", second_column_content: event_booking.industry)
  end

  def nature_of_business
    return nil unless event_booking.nature_of_business
    two_column_row(first_column_content: "Nature of Business", second_column_content: event_booking.nature_of_business)
  end

  def address_fields
    [address_line_1, address_line_2, town, postcode].compact.join("\n")
  end



  private

  def two_column_row(first_column_content:, second_column_content: )
    h.content_tag :div, class: "row" do
      h.concat h.content_tag(:div, first_column_content, class: "small-12 medium-4 columns")
      h.concat h.content_tag(:div, second_column_content, class: "small-12 medium-8 columns")
    end
  end
end
