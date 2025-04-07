class Company < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :templates, dependent: :destroy
    has_many :api_keys, dependent: :destroy
  
    validates :name, presence: true
    validates :terms_accepted, acceptance: true
  end