# frozen_string_literal: true

require 'test_helper'

class HomeMaintenanceTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HomeMaintenance::VERSION
  end

  def test_it_returns_a_list_of_task_like_objects
    subject_class.call(time_frame: :all).each do |res|
      assert_respond_to res, :season
      assert_respond_to res, :area
      assert_respond_to res, :task_type
      assert_respond_to res, :task_name
    end
  end

  # NOTE: this is dependent on the actual data in the CSV
  def test_it_returns_data_as_expected
    result = subject_class.call(time_frame: :all).first
    assert_equal 'Fall', result.season
    assert_equal 'Appliances', result.area
    assert_equal 'Cleaning', result.task_type
    assert_equal 'Clean AC condensor', result.task_name
  end

  private

  def subject_class
    HomeMaintenance
  end
end
