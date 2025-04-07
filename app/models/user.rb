class User < ApplicationRecord
  belongs_to :company
  has_secure_password

  enum :role, { admin: 0, editor: 1 }
end
