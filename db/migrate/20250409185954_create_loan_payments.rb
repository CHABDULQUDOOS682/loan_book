class CreateLoanPayments < ActiveRecord::Migration[8.0]
  def change
    create_table :loan_payments do |t|
      t.decimal :amount
      t.string :given_by
      t.string :given_to
      t.string :witness
      t.date :given_date
      t.date :due_date
      t.decimal :total_receivable
      t.decimal :received_amount
      t.boolean :is_cleared
      t.text :notes
      t.references :book_loan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
