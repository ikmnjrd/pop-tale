class ContactMailer < ApplicationMailer
  default from: "contact@hoge.com"   # 送信元アドレス
  default to: "ikmonjara2rnmt@gmail.com"     # 送信先アドレス
 
  def received_email(contact)
    @contact = contact
    mail(:subject => 'お問い合わせを承りました',
            template_path: 'contact',
            template_name: 'contact_mail')
  end
end
