Rails.application.configure do
    config.after_initialize do
        RailsAdmin::Config::Actions.add_action "tcp_debug", :base, :root do
            show_in_sidebar true
            show_in_navigation false
            breadcrumb_parent [nil]
            # This ensures the action only shows up for Users
            # visible? authorized?
            # Not a member action
            member false
            # Not a colleciton action
            collection false
            
            link_icon 'fas fa-heartbeat'
            
            # You may or may not want pjax for your action
            # pjax? true
            
            http_methods [:get]
            # Adding the controller which is needed to compute calls from the ui
            controller do
                proc do # This is needed because we need that this code is re-evaluated each time is called
                    if request.xhr?
                        case params["test"]
                        when "telnet"
                            port_is_open = Socket.tcp(params["host"], params["port"], connect_timeout: 5) { true } rescue false
                            message, status = { debug_status: I18n.t("tcp_debug_telnet_ko", host: params["host"].presence || "-", port: params["port"].presence || "-") }, 503
                            message, status = { debug_status: I18n.t("tcp_debug_telnet_ok", host: params["host"].presence || "-", port: params["port"].presence || "-") }, 200 if port_is_open
                        when "ping"
                            check = Net::Ping::External.new(params["host"])
                            message, status = { debug_status: I18n.t("tcp_debug_ping_ko", host: params["host"].presence || "-") }, 503
                            message, status = { debug_status: I18n.t("tcp_debug_ping_ok", host: params["host"].presence || "-") }, 200 if check.ping?
                        else
                            message, status = { debug_status: I18n.t("invalid_test", host: params["host"]) }, 400
                        end
                        render json: message.to_json, status: status  
                    end
                end
            end
        end
    end
end