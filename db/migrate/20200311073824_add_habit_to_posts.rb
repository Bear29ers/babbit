class AddHabitToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :habit, :string
  end
end
