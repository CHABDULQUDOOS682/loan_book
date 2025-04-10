class BookLoan < ApplicationRecord
  belongs_to :user
  has_many :loan_book_users
  has_many :shared_users, through: :loan_book_users, source: :user
  has_many :loan_payments

  validates :name, presence: true
end
