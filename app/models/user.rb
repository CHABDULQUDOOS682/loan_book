class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :book_loans, foreign_key: "user_id"
  has_many :loan_book_users
  has_many :shared_loan_books, through: :loan_book_users, source: :book_loan
  has_many :loan_payments

  validates :name, presence: true
end
