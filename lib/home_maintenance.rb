# frozen_string_literal: true

require 'csv'
require 'octokit'

require_relative './home_maintenance/version'
require_relative './home_maintenance/task'
require_relative './home_maintenance/time_framer'

# Read data on tasks. Convert them to task objects.
class HomeMaintenance
  class Error < StandardError; end
  DEFAULT_DATA_PATH = './data/tasks.csv'

  def self.call(config = {})
    new(**config).call
  end

  def initialize(config = {})
    @issue_client = config[:issue_client] || Octokit::Client.new(access_token: config[:github_token])
    @task_class = config[:task_class] || Task
    @time_framer_class = config[:time_framer_class] || TimeFramer

    @repo_nwo = config[:repo_nwo]
    @path_to_data = config[:path_to_data] || DEFAULT_DATA_PATH
    @time_frame = config[:time_frame] || :seasonal
    @run_date = config[:run_date] || Date.today
    ensure_required_fields_set!
  end

  def call
    build_task_objects.map do |task|
      @issue_client.create_issue(
        @repo_nwo,
        task.task_name,
        '**created by https://github.com/maxbeizer/home_maintenance**',
        labels: ['home_maintenance', task.area, task.task_type].join(',')
      )

      break
      # task
    end
  end

  private

  def all?
    @time_frame == :all
  end

  def time_frame_matches?(task)
    @time_framer_class.new(task, @run_date).matches?
  end

  def build_task_objects
    CSV.read(@path_to_data).each_with_object([]) do |row, acc|
      task = @task_class.new(row).call
      next unless task

      acc << task if all? || time_frame_matches?(task)
    end.compact
  end

  def ensure_required_fields_set!
    raise Error, 'repo_nwo must be set!' if @issue_client.is_a?(Octokit::Client) && !@repo_nwo
  end
end

HomeMaintenance.call(github_token: ARGV[0], repo_nwo: ARGV[1]) if $PROGRAM_NAME == __FILE__
