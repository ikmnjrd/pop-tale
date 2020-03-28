class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

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

end
