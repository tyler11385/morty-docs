class Placeholder < ApplicationRecord
  belongs_to :template

  enum placeholder_type: {
    date: 0,
    datetime: 1,
    name: 2,
    signature: 3,
    string: 4,
    number: 5,
    page_counter: 6,
    barcode: 7
}

  validates :name, :placeholder_type, presence: true
end