class EventBookingPresenter < BasePresenter
  presents :event_booking

  delegate :nature_of_business, :phone_number, :name, :company_name, :industry, :email, :price, :stripe_price, to: :event_booking

  def company_name
    return nil unless event_booking.company_name
    two_column_row(first_column_content: "Company Name", second_column_content: event_booking.company_name)
  end

  def address
    return nil unless event_booking.address
    two_column_row(first_column_content: "Address", second_column_content: h.simple_format(event_booking.address))
  end

  def industry
    return nil unless event_booking.industry
    two_column_row(first_column_content: "Industry", second_column_content: event_booking.industry)
  end

  def nature_of_business
    return nil unless event_booking.nature_of_business
    two_column_row(first_column_content: "Nature of Business", second_column_content: event_booking.nature_of_business)
  end



  private

  def two_column_row(first_column_content:, second_column_content: )
    h.content_tag :div, class: "row" do
      h.concat h.content_tag(:div, first_column_content, class: "small-12 medium-4 columns")
      h.concat h.content_tag(:div, second_column_content, class: "small-12 medium-8 columns")
    end
  end
end
