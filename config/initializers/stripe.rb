if Rails.env.development? || Rails.env.test?
  Rails.configuration.stripe = {
    publishable_key: "pk_test_ctY0mVOlapGoFqWIvByD4zH3",
    secret_key: "sk_test_8sU0HQQY9IEjx5u2jRD8qrkl"
  }
else
  Rails.configuration.stripe = {
    publishable_key: ENV['PUBLISHABLE_KEY'],
    secret_key: ENV['SECRET_KEY']
  }
  #Stripe.api_key = "sk_live_wYKGm7WlLxD2HJeTfcmkQXQW"
  #STRIPE_PUBLIC_KEY = "pk_live_XI3b5c3GpmnYR3K1PU6Upufj"
end
Stripe.api_key = Rails.configuration.stripe[:secret_key]