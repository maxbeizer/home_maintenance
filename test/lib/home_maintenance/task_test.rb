# frozen_string_literal: true

require 'test_helper'

class HomeMaintenance
  class TaskTest < Minitest::Test
    def test_it_returns_nil_for_the_headers
      subject = subject_class.new(subject_class::HEADERS)
      assert_nil subject.call, 'Expected headers as input to return nil'
    end

    def test_it_returns_the_headers_instace_variables
      result = subject_class.new([
        'Fall',
        'Appliances',
        'Cleaning',
        'Clean AC condensor'
      ]).call

      assert_equal 'Fall', result.season
      assert_equal 'Appliances', result.area
      assert_equal 'Cleaning', result.task_type
      assert_equal 'Clean AC condensor', result.task_name
    end

    private

    def subject_class
      HomeMaintenance::Task
    end
  end
end
