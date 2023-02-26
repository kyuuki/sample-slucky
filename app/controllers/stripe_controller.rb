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
        subscription_data: {
          metadata: {
            user_id: current_user.id
          }
        },
        #success_url: stripe_success_url(session_id: "{CHECKOUT_SESSION_ID}"),
        success_url: "#{stripe_success_url}?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: root_url,
      })
    rescue StandardError => e
      halt 400,
           { "Content-Type" => "application/json" },
           { "error": { message: e.error.message } }.to_json
    end

    # TODO: エラー処理
    StripeSession.create(
      user: current_user,
      session_identifier: session.id
    )

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

    puts event_type

    if event.type == 'customer.subscription.deleted'
      # handle subscription canceled automatically based
      # upon your subscription settings. Or if the user cancels it.
      # puts data_object
      puts "Subscription canceled: #{event.id}"
    end

    if event.type == 'customer.subscription.updated'
      # handle subscription updated
      # puts data_object
      puts "Subscription updated: #{event.id}"

      stripe_customer_identifier = data_object["customer"]
      user_id = data_object["metadata"]["user_id"].to_i  # TODO: なかった場合のエラー処理
      puts stripe_customer_identifier
      puts user_id

      # TODO: created で作る？
      # TODO: User の存在チェック
      # TODO: Customer すでにある場合は？
      # TODO: いろいろチェックすること多い
      user_stripe = UserStripe.find_or_create_by(user_id: user_id)
      user_stripe.update(
        stripe_customer_identifier: stripe_customer_identifier,
        status: "subscription"
      )

      # TODO: 有効期間を更新
    end

    if event.type == 'customer.subscription.created'
      # handle subscription created
      # puts data_object
      puts "Subscription created: #{event.id}"
    end

    head :ok
  end
end
