module HealthInspector
  class ValidationResult

    attr_reader :failures, :item_name

    def initialize(item_name, failures)
      @failures = failures
      @item_name = item_name
    end

    def success?
      @failures.empty?
    end

  end
end
