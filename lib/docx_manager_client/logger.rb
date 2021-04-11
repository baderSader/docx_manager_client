module DocxManagerClient
  module Logger

    def self.logger
      @@logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
    end

    def self.logger=(logger)
      @@logger = logger
    end

    ActiveSupport::Notifications.subscribe('request.faraday') do |name, starts, ends, _, env|
      url         = env[:url]
      http_method = env[:method].to_s.upcase
      duration    = (ends - starts)
      response    = env.response.body
      info        = "\e[96m \e[1m DocxManagerClient \e[0m \e[33m #{url.host} #{http_method}\e[0m \e[92m #{env.status}\e[0m \e[1m \e[32m(#{duration} seconds) \e[0m \e[4m#{url.request_uri}\e[0m"
      debug       = "DocxManagerClient::#{response}"
      DocxManagerClient::Logger.logger.info  info
      DocxManagerClient::Logger.logger.debug debug
    end
  end
end
