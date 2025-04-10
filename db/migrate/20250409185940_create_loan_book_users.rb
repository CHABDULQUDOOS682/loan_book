class CreateLoanBookUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :loan_book_users do |t|
      t.references :book_loan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :access_level, null: false, default: "view"

      t.timestamps
    end
  end
end
