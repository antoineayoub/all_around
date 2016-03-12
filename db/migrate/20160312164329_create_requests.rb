class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :content
      t.string :status
      t.string :category

      t.timestamps null: false
    end
  end
end
