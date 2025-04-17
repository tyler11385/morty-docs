module Api
  class DocumentsController < ApplicationController
    # Optional: Add authentication filters here (e.g., JWT or API key)

    def create
      template = Template.find_by(id: params[:template_id])
      return render json: { error: 'Template not found' }, status: :not_found unless template

      document = Document.new(
        template: template,
        placeholders: params[:placeholders],
        external_reference: params[:external_reference],
        user_id: current_user&.id || 1 # fallback or real user context
      )

      if document.save
        DocumentGeneratorService.new(document).generate!

        render json: {
          document_id: document.id,
          status: document.status,
          template_id: template.id,
          external_reference: document.external_reference,
          created_at: document.created_at,
          url: api_document_url(document)
        }, status: :created
      else
        render json: { errors: document.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      document = Document.find_by(id: params[:id])
      return render json: { error: 'Document not found' }, status: :not_found unless document

      template = document.template

      render json: {
        document_id: document.id,
        template_id: template.id,
        status: document.status || "created",
        generated_at: document.generated_at,
        external_reference: document.external_reference,
        content: rendered_content(document),
        placeholders: template.placeholders.map do |ph|
          {
            name: ph.name,
            type: map_placeholder_type(ph),
            mapping: ph.mapping,
            position: placeholder_position_stub(ph)
          }
        end
      }
    end
   
    def pdf
      document = Document.find(params[:id])
      html = document.rendered_content
    
      pdf = WickedPdf.new.pdf_from_string(html)
    
      send_data pdf, filename: "document-#{document.id}.pdf", type: "application/pdf", disposition: "inline"
    end
    
    private

    def rendered_content(document)
      template = document.template
      raw_content = template.content

      raw_content.gsub(/\{\{\s*(\w+)\s*\}\}/) do |_match|
        key = Regexp.last_match(1)
        document.data&.dig(key) || "[MISSING #{key}]"
      end
    end

    def map_placeholder_type(ph)
      case ph.placeholder_type
      when "signature", 1 then "signature"
      when "date", 2 then "date"
      when "checkbox", 3 then "checkbox"
      when "radio", 4 then "radio"
      else "text_field"
      end
    end

    def placeholder_position_stub(_ph)
      {
        page: 1, # Stub for now — replace with real logic later
        x: rand(50..400),
        y: rand(100..700)
      }
    end
  end
end
