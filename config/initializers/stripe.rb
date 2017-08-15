Rails.configuration.stripe = {
  :publishable_key => 'pk_test_Yo4NxqkoglGM7UQNnjumRhkv',
  :secret_key      => 'sk_test_JgKIVv8fRwtv5puSdHKypgA3'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]