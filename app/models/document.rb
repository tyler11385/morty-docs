class Document < ApplicationRecord
  belongs_to :template

  validates :title, :data, presence: true
end