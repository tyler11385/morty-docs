class ApiKey < ApplicationRecord
  belongs_to :company

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
