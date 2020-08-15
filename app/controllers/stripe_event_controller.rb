class StripeEventController < ApplicationController
  # before_actionをpayment_processに追記する
  # どうやって???

  def payment_profile
    @painting = Painting.find(params[:painting_id])
    gon.pk_key = ENV['STRIPE_PUBLISHABLE_KEY']

    @redirect_url = stripe_event_payment_process_path

    @payment_intent = Stripe::PaymentIntent.create({
      payment_method_types: ['card'],
      amount: @painting.price,
      currency: 'jpy',
      application_fee_amount: @painting.price / 20,
      transfer_data: {
        destination: @painting.user.stripe_uid,
      },
      #削除するやつっぽ（デバック的な）
      #https://stripe.com/docs/payments/accept-a-payment#web-collect-card-details
      metadata: {integration_check: 'accept_a_payment'},
    })
  #お試し
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to mypage_path #指定のPaintingのパスにする
  end

  def payment_process
    # before_actionを入れればいいのかな...
    # どうやって値を渡そうか
    @painting = Painting.find(params[:painting_id])
    
    # 売れた時の処理
    if @painting.update(purchase_id: current_user.id)
      redirect_to root_path, notice: "商品を購入しました" #product_path(params[:id]), notice: "商品を購入しました！"
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to mypage_path #指定のPaintingのパスにする
  end

  # あとで実装（今はルーティングしてない）
  def revoke_stripe
    Stripe::OAuth.deauthorize({
      client_id: 'ca_GzhdixzBgTTRUcjfKg7WkrnSDUE1xn69',
      stripe_user_id: 'acct_1Ggu6YClYQGTKHdu',#user.stripe_uid,
    })
    flash[:success] = "stripe設定を取り消しました"
    redirect_to root_path
  end

  
end
