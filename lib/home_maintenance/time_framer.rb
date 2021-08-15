# frozen_string_literal: true

class HomeMaintenance
  # Given a task, figure out if it what whether it's in a given time frame
  class TimeFramer
    SEASON_START_MAP = {
      spring: [20, 3],
      summer: [20, 6],
      fall: [22, 9],
      winter: [21, 12]
    }.freeze

    def initialize(task, today = Date.today)
      @task = task
      @today = today
    end

    def matches?
      season_start == [@today.day, @today.month]
    end

    private

    def season_start
      SEASON_START_MAP[@task.season.downcase.to_sym]
    end
  end
end
