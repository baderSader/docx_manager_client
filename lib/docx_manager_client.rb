require "docx_manager_client/version"

require "docx_manager_client/logger"
require "docx_manager_client/connection"
require "docx_manager_client/model"

module DocxManagerClient
  class DependencyError < StandardError; end
end
include DocxManagerClient::Logger
include DocxManagerClient::Connection

require "active_model/callbacks"
ActiveModel::Callbacks.include(DocxManagerClient::Model)

ActiveSupport.on_load(:active_record) do
  extend DocxManagerClient::Model
end
