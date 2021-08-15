# frozen_string_literal: true

require 'test_helper'

class HomeMaintenance
  class TimeFramerTest < Minitest::Test
    def test_returns_true_when_spring_task_is_start_of_spring
      task = Task.new(['Spring']).call
      start_of_spring = Date.new(2021, 3, 20)

      assert subject_class.new(task, start_of_spring).matches?
    end

    def test_returns_false_when_spring_task_is_not_at_start_of_spring
      task = Task.new(['Spring']).call
      not_start_of_spring = Date.new(2021, 3, 21)

      refute subject_class.new(task, not_start_of_spring).matches?
    end

    def test_returns_true_when_summer_task_is_start_of_summer
      task = Task.new(['Summer']).call
      start_of_summer = Date.new(2021, 6, 20)

      assert subject_class.new(task, start_of_summer).matches?
    end

    def test_returns_false_when_summer_task_is_not_at_start_of_summer
      task = Task.new(['Summer']).call
      not_start_of_summer = Date.new(2021, 6, 21)

      refute subject_class.new(task, not_start_of_summer).matches?
    end

    def test_returns_true_when_fall_task_is_start_of_fall
      task = Task.new(['Fall']).call
      start_of_fall = Date.new(2021, 9, 22)

      assert subject_class.new(task, start_of_fall).matches?
    end

    def test_returns_false_when_fall_task_is_not_at_start_of_fall
      task = Task.new(['Fall']).call
      not_start_of_fall = Date.new(2021, 9, 21)

      refute subject_class.new(task, not_start_of_fall).matches?
    end

    def test_returns_true_when_winter_task_is_start_of_winter
      task = Task.new(['Winter']).call
      start_of_winter = Date.new(2021, 12, 21)

      assert subject_class.new(task, start_of_winter).matches?
    end

    def test_returns_false_when_winter_task_is_not_at_start_of_winter
      task = Task.new(['Winter']).call
      not_start_of_winter = Date.new(2021, 12, 20)

      refute subject_class.new(task, not_start_of_winter).matches?
    end

    private

    def subject_class
      HomeMaintenance::TimeFramer
    end
  end
end
