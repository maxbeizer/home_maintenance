# frozen_string_literal: true

# Home to all custom exceptions
class HomeMaintenance
  class Error < StandardError; end

  # When the input to the Action is invalid
  class InvalidInputError < Error
    def initialize(msg = 'Action config is invalid')
      super
    end
  end

  # When the calculated path to the CSV file cannot be found
  class CSVReadError < Error
    def initialize(msg = 'Unable to find CSV file of tasks')
      super
    end
  end
end
