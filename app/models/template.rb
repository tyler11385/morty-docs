class Template < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :placeholders, dependent: :destroy
  has_many :documents, dependent: :nullify

  STATUSES = {
    draft: 0,
    approved: 1,
    archived: 2
  }.freeze

  validates :name, :status, :content, presence: true

  # Scopes
  scope :draft, -> { where(status: STATUSES[:draft]) }
  scope :approved, -> { where(status: STATUSES[:approved]) }

  def status_name
    STATUSES.key(status)
  end

  def draft?
    status == STATUSES[:draft]
  end

  def approved?
    status == STATUSES[:approved]
  end

  def archived?
    status == STATUSES[:archived]
  end

  def required_placeholder_keys
    content.scan(/\{\{\s*(\w+)\s*\}\}/).flatten.uniq
  end
end
