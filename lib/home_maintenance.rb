# frozen_string_literal: true

require 'csv'

require_relative './home_maintenance/version'
require_relative './home_maintenance/task'

# Read data on tasks. Convert them to task objects.
class HomeMaintenance
  class Error < StandardError; end
  DEFAULT_DATA_PATH = './data/tasks.csv'

  def self.call(path_to_data = DEFAULT_DATA_PATH)
    new(path_to_data).call
  end

  def initialize(path_to_data = DEFAULT_DATA_PATH)
    @path_to_data = path_to_data
  end

  def call
    build_task_objects
  end

  private

  def build_task_objects
    CSV.read(@path_to_data).each_with_object([]) do |row, acc|
      acc << Task.new(row).call
    end.compact
  end
end
