class ContactController < ApplicationController
  
  def index
    @contact = Contact.new
  end

  def confirm
    # 入力値のチェック
    
  end

  ##### 問い合わせ完了画面の処理
  def thanks
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.received_email(@contact).deliver_now
    else
      render :index
    end
    # 問い合わせ内容をChatWorkへ通知
    #@chatwork = InquiryChatwork.new
    #@chatwork.push_chatwork_message(@contact)
  end

  private
      ##### Strong Parametersで問い合わせ画面からの入力を許可するリクエストパラメータを指定する
      def contact_params
        params.require(:contact).permit(
          :name, :email, :message
        )
      end

end