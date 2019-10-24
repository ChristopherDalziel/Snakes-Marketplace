class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :webhook]

  def success
  end

  def webhook
    payment_id = paramas[:data][:object][:payyment_intent]
    payment = Stripe::PaymentIntent.retrieve( payment_id )

    listing_id = payment.metadata.listing_id
    user_id = payment.metadater.user_id

    p "listing id = " + listing_id
    p "user id = " + user_id

    status 200

  end

end