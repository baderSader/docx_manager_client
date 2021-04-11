require 'faraday_middleware'
require 'hashie'

module DocxManagerClient
  module Connection
    class ConfigMissing < StandardError; end

    def self.docx_server_api(method, path, body = {})
      response = docx_server_json.send(method, path, body)
      [response.status, Hashie::Mash.new(response.body)]
    end

    def self.docx_server_api_multipart(method, path, payload)
      response = docx_server_multipart.send(method, path, payload)
      [response.status, Hashie::Mash.new(response.body)]
    end

    def self.docx_server_headers
      {
        'client'        => docx_manager_api_key,
        'Authorization' => docx_manager_token,
        'User-Agent'    => "DocxManagerClient #{DocxManagerClient::VERSION}"
      }
    end

    def self.docx_server_json
      @docx_server_json ||= Faraday.new(url: "#{docx_manager_server_path}/api/v1", headers: docx_server_headers) do |f|
        f.request   :json
        f.use       :instrumentation
        f.response  :json
        f.adapter   :net_http
      end
    end

    def self.docx_server_multipart
      @docx_server_multipart ||= Faraday.new(url: "#{docx_manager_server_path}/api/v1", headers: docx_server_headers) do |f|
        f.request   :multipart
        f.request   :url_encoded
        f.use       :instrumentation
        f.response  :json
        f.adapter   :net_http
      end
    end

    def self.docx_manager_server_path
      exist = ENV['DOCX_MANAGER_SERVER_PATH'] || Rails.application.secrets[:docx_manager_server_path]
      raise ConfigMissing.new("ENV['DOCX_MANAGER_SERVER_PATH'] or Rails.application.secrets[:docx_manager_server_path] not exist") if exist.blank?

      exist.to_s
    end

    def self.docx_manager_api_key
      exist = ENV['DOCX_MANAGER_API_KEY'] || Rails.application.secrets[:docx_manager_api_key]
      raise ConfigMissing.new("ENV['DOCX_MANAGER_API_KEY'] or Rails.application.secrets[:docx_manager_api_key] not exist") if exist.blank?

      exist.to_s
    end

    def self.docx_manager_token
      exist = ENV['DOCX_MANAGER_TOKEN'] || Rails.application.secrets[:docx_manager_token]
      raise ConfigMissing.new("ENV['DOCX_MANAGER_TOKEN'] or Rails.application.secrets[:docx_manager_token] not exist") if exist.blank?

      exist.to_s
    end
  end
end
