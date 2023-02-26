#
# Stripe コントローラー
#
class StripeController < ApplicationController
  # TODO: Webhook は別にした方がよさそう
  before_action :authenticate_registrated_user!, except: :webhook
  protect_from_forgery except: :webhook

  Stripe.api_key = ENV["STRIPE_API_KEY"]

  # 購入ページ
  def index
  end

  # 購入するボタン
  def create
    prices = Stripe::Price.list(
      expand: ["data.product"]
    )

    begin
      session = Stripe::Checkout::Session.create({
        mode: "subscription",
        customer_email: current_user.email,
        line_items: [{
          quantity: 1,
          price: prices.data[0].id
        }],
        #success_url: stripe_success_url(session_id: "{CHECKOUT_SESSION_ID}"),
        success_url: "#{stripe_success_url}?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: root_url,
      })
    rescue StandardError => e
      halt 400,
           { "Content-Type" => "application/json" },
           { "error": { message: e.error.message } }.to_json
    end

    redirect_to session.url, allow_other_host: true
  end

  def success
    session_id = params["session_id"]

    # TODO: Webhook が来てない場合ある？

    redirect_to root_url
  end

  def webhook
    webhook_secret = ""
    payload = request.body.read

    data = JSON.parse(payload, symbolize_names: true)
    event = Stripe::Event.construct_from(data)

    event_type = event["type"]
    data = event["data"]
    data_object = data["object"]
    stripe_customer_identifier = data_object["customer"]

    puts event_type
    puts stripe_customer_identifier

    head :ok
  end
end
