# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += %i[
  password
  password_confirmation
  forename
  surname
  first_name
  last_name
  name
  occupation
  job_role
  job_description
  email
  email_address
  address_line_1
  address_line_2
  city
  postcode
  post_code
  address
  username
  user_id
  phone_number
  mobile_number
  telephone
  mobile
  gender
  date_of_birth
  age
  age_in_years
]
