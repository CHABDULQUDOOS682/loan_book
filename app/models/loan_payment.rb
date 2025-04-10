class LoanPayment < ApplicationRecord
  belongs_to :book_loan
  belongs_to :user
  has_one_attached :document

  validates :amount, :given_by, :given_to, :given_date, :due_date, :total_receivable, presence: true
  validates :amount, :total_receivable, :received_amount, numericality: { greater_than_or_equal_to: 0 }

  before_save :update_cleared_status

  private

  def update_cleared_status
    self.is_cleared = (received_amount >= total_receivable) if received_amount_changed? || total_receivable_changed?
  end
end
