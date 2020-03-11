require 'test_helper'

class HabitTest < ActiveSupport::TestCase
  def setup
    @habit = Habit.new(habit: "Bad Habit", post_id: posts(:test_post4).id, user_id: users(:test_user1).id)
  end

  test "should be valid" do
    assert @habit.valid?
  end

  test "habit should be present" do
    @habit.habit = nil
    assert_not @habit.valid?
  end

  test "habit should be unique" do
    duplicate_habit = @habit.dup
    duplicate_habit.habit = @habit.habit.upcase
    @habit.save
    assert_not duplicate_habit.valid?
  end
end
