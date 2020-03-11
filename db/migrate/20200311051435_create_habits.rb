class CreateHabits < ActiveRecord::Migration[5.1]
  def change
    create_table :habits do |t|
      t.string :habit
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
