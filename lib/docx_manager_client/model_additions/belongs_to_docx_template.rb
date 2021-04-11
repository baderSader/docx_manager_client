module DocxManagerClient
  module ModelAdditions
    module BelongsToDocxTemplate

      def belongs_to_docx_template(name:, belongs_to:, template_type:)
        # dependency check
        raise DocxManagerClient::DependencyError.new("#{self.name} dose not have relation 'belongs_to :#{belongs_to}'") unless self.reflect_on_all_associations(:belongs_to).map(&:name).include?(belongs_to.to_sym)

        # attr_accessor
        attr_accessor :"#{name}_docx_file"

        # callbacks
        after_save    :"post_#{name}_docx"
        after_destroy :"delete_#{name}_docx"

        # instance methods
        define_method "#{name}_docx_path" do
          status, response = DocxManagerClient::Connection.docx_server_api(:get, send("#{name}_docx_request_paht"))
          docx_response_attr(status, response, :docx_url)
        end

        define_method "#{name}_pdf_path" do
          status, response = DocxManagerClient::Connection.docx_server_api(:get, send("#{name}_docx_request_paht"))
          docx_response_attr(status, response, :pdf_url)
        end

        define_method "#{name}_png_path" do
          status, response = DocxManagerClient::Connection.docx_server_api(:get, send("#{name}_docx_request_paht"))
          docx_response_attr(status, response, :png_url)
        end

        define_method "post_#{name}_docx" do
          status, response = DocxManagerClient::Connection.docx_server_api(:post, send("#{name}_docx_request_paht"), send("#{name}_request_attributes"))
          docx_response_attr(status, response)
        end

        define_method "delete_#{name}_docx" do
          status, response = DocxManagerClient::Connection.docx_server_api(:delete, send("#{name}_docx_request_paht"), send("#{name}_request_attributes"))
          docx_response_attr(status, response)
        end

        # private methods
        define_method :docx_response_attr do |status, response, attr = nil|
          if status < 300
            attr.nil? ? response.data : response.data.attributes.send(attr)
          else
            response.errors
          end
        end

        define_method "#{name}_docx_request_paht" do
          reference_record_id   = send("#{belongs_to}_id")
          reference_record_type = self.class.reflect_on_association(belongs_to).klass.name
          record_id             = id
          record_type           = self.class.name
          "templates/#{template_type}/#{reference_record_type}/#{reference_record_id}/generated_documents/#{record_type}/#{record_id}"
        end

        define_method "#{name}_request_attributes" do
          { request_attributes: send("#{name}_docx_hash") }
        end

        define_method "#{name}_docx_hash" do
          raise NotImplementedError,
          "\e[1m\e[91m#{self.class}\e[0m belongs_to_docx_template :#{name} but didn't define \e[91m'#{name}_docx_hash'\e[0m"
        end

        private :docx_response_attr, "#{name}_docx_hash".to_sym, "#{name}_docx_request_paht".to_sym, "#{name}_request_attributes".to_sym

      end
    end
  end
end
