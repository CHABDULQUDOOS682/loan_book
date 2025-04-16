class AddEditedByInToLoanPayment < ActiveRecord::Migration[8.0]
  def change
    add_column :loan_payments, :edited_by, :integer
  end
end
