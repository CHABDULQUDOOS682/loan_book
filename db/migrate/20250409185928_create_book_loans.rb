class CreateBookLoans < ActiveRecord::Migration[8.0]
  def change
    create_table :book_loans do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
