# frozen_string_literal: true

require 'test_helper'

class HomeMaintenanceTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HomeMaintenance::VERSION
  end

  def test_it_returns_a_list_of_task_like_objects
    subject_class.call(time_frame: :all, issue_client: MockIssueClient, logger: noop).each do |res|
      assert_respond_to res, :season
      assert_respond_to res, :area
      assert_respond_to res, :task_type
      assert_respond_to res, :task_name
    end
  end

  # NOTE: this is dependent on the actual data in the CSV
  def test_it_returns_data_as_expected
    result = subject_class.call(time_frame: :all, issue_client: MockIssueClient, logger: noop).first
    assert_equal 'Fall', result.season
    assert_equal 'Appliances', result.area
    assert_equal 'Cleaning', result.task_type
    assert_equal 'Clean AC condensor', result.task_name
  end

  def test_it_errors_if_octokit_is_there_but_nwo_is_falsey
    assert_raises HomeMaintenance::InvalidInputError, 'expected octokit + no repo_nwo to raise' do
      subject_class.call(logger: noop)
    end
  end

  def test_it_errors_if_octokit_is_there_but_nwo_is_empty
    assert_raises HomeMaintenance::InvalidInputError, 'expected octokit + no repo_nwo to raise' do
      subject_class.call(logger: noop, repo_nwo: '')
    end
  end

  def test_it_errors_if_time_frame_is_invalid
    assert_raises HomeMaintenance::InvalidInputError, 'expected octokit + no repo_nwo to raise' do
      subject_class.call(time_frame: 'lololol', issue_client: MockIssueClient, logger: noop)
    end
  end

  def test_it_errors_if_csv_does_not_exist
    assert_raises HomeMaintenance::CSVReadError, 'expected raise with bad CSV path' do
      subject_class.call(logger: noop, path_to_data: 'lol/wut.csv', repo_nwo: 'maxbeizer/home_maintenenace')
    end
  end

  private

  class MockIssueClient
    def self.create_issue(*args); end
  end

  def subject_class
    HomeMaintenance
  end

  def noop
    proc { true }
  end
end
