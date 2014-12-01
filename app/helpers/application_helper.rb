module ApplicationHelper

    def full_title(page_title = '')
        base_title = "Mug Booklet"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end

    def resource_name
        :user
    end

    def resource
        @resource ||= User.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end

    def errors_helper(thing, symbol)
        thing.errors[symbol].map{|i| i}.join(" ")
    end
end
