module ApplicationHelper

  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "aiilust"
    if page_title.empty?
    base_title
    else
    page_title + " | " + base_title
    end
  end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # stripe_connectに置ける売り手登録用のURL
  def stripe_url
    #"https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV['STRIPE_CLIENT_ID']}&scope=read_write"
    "https://connect.stripe.com/express/oauth/authorize?redirect_uri=/users/auth/stripe_connect/callback&client_id=#{ENV['STRIPE_CLIENT_ID']}&state={STATE_VALUE}&stripe_user[email]=#{current_user.email}"
  end
end