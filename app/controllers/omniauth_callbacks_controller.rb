class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    #参考 https://qiita.com/svfreerider/items/6ca4517575edcd5da6e8
    def hinan_stripe_connect
      auth_data = request.env["omniauth.auth"]
      logger.debug(auth_data)
      @user = current_user
      if @user.persisted?
        @user.stripe_uid = auth_data.uid
        #publishable_key、いる？？
        @user.publishable_key = auth_data.info.stripe_publishable_key
        @user.save
    
        sign_in_and_redirect @user, event: :authentication
        flash[:notice] = 'Stripe Account Created And Connected' if is_navigational_format?
       else
         session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
         redirect_to root_path
       end
    end

    def stripe_connect
        auth_data = request.env["omniauth.auth"]
        
        #logger.debug(auth_data.to_yaml)
        @user = current_user

        if @user.persisted?
          # Access the connected account id in the response
          @user.stripe_uid = auth_data.extra.raw_info.stripe_user_id
          @user.save
          sign_in_and_redirect @user, event: :authentication
          flash[:notice] = 'Stripe Account Created And Connected' if is_navigational_format?
        else
         session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
         redirect_to root_path
       end
    end

end