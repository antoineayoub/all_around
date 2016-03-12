class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :gender, :string
    add_column :users, :age, :integer
    add_column :users, :country_of_origin, :string
    add_column :users, :address, :string
    add_column :users, :arrival_date, :datetime
  end
end
