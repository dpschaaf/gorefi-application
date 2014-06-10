class AddLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :state
      t.integer :fico
      t.integer :annual_gross_income
      t.integer :downpayment_amount
      t.integer :monthly_debt
      t.float :downpayment_percent
      t.integer :max_home_amount
      t.integer :loan_amount
      t.float :monthly_payment
      t.string :email
      t.string :full_name
    end
  end
end

