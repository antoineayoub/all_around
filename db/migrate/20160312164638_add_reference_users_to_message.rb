class AddReferenceUsersToMessage < ActiveRecord::Migration
  def change
    add_column :requests, :refugee_id, :integer
    add_column :requests, :volunteer_id, :integer
  end
end
