module DocxManagerClient
  module ModelAdditions
    module DocxTemplate
      def docx_template(template_type:)

        # attr_accessor
        attr_accessor :"#{template_type}_docx_file"

        # callbacks
        after_save    :"post_#{template_type}_document"
        after_destroy :"delete_#{template_type}_document"

        # instance methods
        define_method "#{template_type}_docx_path" do
          status, response = DocxManagerClient::Connection.docx_server_api(:get, send("#{template_type}_docx_request_paht"))
          docx_response_attr(status, response, :docx_url)
        end

        define_method "post_#{template_type}_document" do
          return unless send("#{template_type}_docx_file").present?

          file = Faraday::FilePart.new(
            send("#{template_type}_docx_file").tempfile.path,
            send("#{template_type}_docx_file").content_type,
            send("#{template_type}_docx_file").original_filename
          )
          payload = { template: { document: file } }
          status, response = DocxManagerClient::Connection.docx_server_api_multipart(:post, send("#{template_type}_docx_request_paht"), payload)
          docx_response_attr(status, response, :docx_url)
        end

        define_method "delete_#{template_type}_document" do
          status, response = DocxManagerClient::Connection.docx_server_api(:delete, send("#{template_type}_docx_request_paht"))
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

        define_method "#{template_type}_docx_request_paht" do
          "templates/#{template_type}/#{self.class.name}/#{id}"
        end

        private :docx_response_attr, "#{template_type}_docx_request_paht".to_sym
      end
    end
  end
end
