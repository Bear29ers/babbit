class DeleteHabitFromHabit < ActiveRecord::Migration[5.1]
  def change
    drop_table :habits
  end
end
