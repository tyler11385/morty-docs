class Template < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :placeholders, dependent: :destroy
  has_many :documents, dependent: :nullify

  enum status: { draft: 'draft', approved: 'approved' }

  validates :title, :status, :content, presence: true
end