class LoanBookUser < ApplicationRecord
  belongs_to :book_loan
  belongs_to :user

  enum :access_level, view: "view", admin: "admin"
end
