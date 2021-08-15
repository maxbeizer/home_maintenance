# frozen_string_literal: true

class HomeMaintenance
  # Given a row, build a task object
  class Task
    HEADERS = ['Season', 'Area', 'Task Type', 'Task'].freeze

    attr_reader :season,
                :area,
                :task_type,
                :task_name

    def initialize(row)
      @row = row
    end

    def call
      return if @row == HEADERS

      HEADERS.zip(@row).each do |(header, cell)|
        header_munged = header.downcase.sub(/\s/, '_')

        if header_munged == 'task'
          instance_variable_set("@#{header_munged}_name", cell)
          next
        end

        instance_variable_set("@#{header_munged}", cell)
      end

      self
    end
  end
end
