# app/models/document.rb
class Document < ApplicationRecord
  belongs_to :template

  validates :template, presence: true
  validates :placeholders, presence: true
  validate :validate_placeholders_match_template

  def validate_placeholders_match_template
    return unless template.present?

    required_keys = template.required_placeholder_keys
    missing_keys = required_keys - placeholders.keys.map(&:to_s)

    if missing_keys.any?
      errors.add(:placeholders, "missing required keys: #{missing_keys.join(', ')}")
    end
  end
  def rendered_content
    template.content.gsub(/\{\{\s*(\w+)\s*\}\}/) do |_match|
      key = Regexp.last_match(1)
      data[key] || "[MISSING #{key}]"
    end
  end
  
end
