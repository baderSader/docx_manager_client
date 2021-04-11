require_relative './model_additions/belongs_to_docx_template.rb'
require_relative './model_additions/docx_template.rb'

module DocxManagerClient
  module Model
    include DocxManagerClient::ModelAdditions::BelongsToDocxTemplate
    include DocxManagerClient::ModelAdditions::DocxTemplate
  end
end
