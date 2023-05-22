Rails.application.configure do
    config.after_initialize do
        require 'root_actions/tcp_debug'
    end
end