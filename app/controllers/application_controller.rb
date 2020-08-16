class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    # devise用
    before_action :configure_permitted_parameters, if: :devise_controller?

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def custom_paginate_renderer
      # Return nice pagination for materialize
      Class.new(WillPaginate::ActionView::LinkRenderer) do
        def container_attributes
            {class: "pagination center"}
        end
        
        def page_number(page)
          if page == current_page
            "<li class=\"cyan active\">"+link(page, page, rel: rel_value(page))+"</li>"
          else
            "<li class=\"waves-effect\">"+link(page, page, rel: rel_value(page))+"</li>"
          end
        end
        
        def previous_page
          num = @collection.current_page > 1 && @collection.current_page - 1
          previous_or_next_page(num, "<i class=\"material-icons\">chevron_left</i>")
        end
        
        def next_page
          num = @collection.current_page < total_pages && @collection.current_page + 1
          previous_or_next_page(num, "<i class=\"material-icons\">chevron_right</i>")
        end
        
        def previous_or_next_page(page, text)
          if page
            "<li class=\"waves-effect\">"+link(text, page)+"</li>"
          else
            "<li class=\"waves-effect\">"+text+"</li>"
          end
        end
      end
    end

    private

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    # deviseのストロングパラメーター
    # passwordは許可しなくてもいいの？？
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    end

    # deviseログイン時
    def after_sign_in_path_for(resource)
      root_path
    end

    def after_inactive_sign_up_path_for(resource)
      root_path
    end
    
    ## deviseログアウト後のリダイレクト先
    #def after_sign_out_path_for(resource)
    #  admin_root_path
    #end

end
