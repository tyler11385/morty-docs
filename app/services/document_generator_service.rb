class DocumentGeneratorService
    def initialize(document)
      @document = document
      @template = document.template
      @placeholders = document.placeholders.with_indifferent_access
    end
  
    def generate!
      rendered_html = render_template
  
      @document.update!(
        data: @placeholders,  # or params[:placeholders] — match your controller
        status: "generated",
        generated_at: Time.current
      )

    end
  
    private
  
    def render_template
      html = @template.content.dup
  
      html.gsub(/\{\{\s*(\w+)\s*\}\}/) do |_match|
        key = Regexp.last_match(1)
        @placeholders[key] || "[[MISSING: #{key}]]"
      end
    end
  end
  