class TestTemplate < ApplicationRecord
    enum status: { draft: 0, approved: 1 }
  end
  