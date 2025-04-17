class Placeholder < ApplicationRecord
  belongs_to :template

  PLACEHOLDER_TYPES = {
    date: 0,
    datetime: 1,
    name: 2,
    signature: 3,
    string: 4,
    number: 5,
    page_counter: 6,
    barcode: 7
  }.freeze

  validates :name, :placeholder_type, presence: true

  def placeholder_type_name
    PLACEHOLDER_TYPES.key(placeholder_type)
  end
end
