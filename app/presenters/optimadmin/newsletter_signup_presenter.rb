module Optimadmin
  class NewsletterSignupPresenter < BasePresenter
    presents :newsletter_signup

    def id
      newsletter_signup.id
    end

    def email_address
      newsletter_signup.email_address
    end
  end
end
