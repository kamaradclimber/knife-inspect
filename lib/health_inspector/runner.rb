module HealthInspector
  module Runner
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :checklist

      def checklist(value = nil)
        return @checklist if value.nil?

        @checklist = value
      end
    end

    def run
      case @name_args.length
      when 1 # We are inspecting an item
        item = @name_args[0]
        validator = self.class.checklist.new(self)
        item = validator.load_item item
        validation_result = validator.validate_item item
        exit validation_result.success?
      when 0 # We are inspecting all the items
        exit self.class.checklist.run(self)
      end
    end
  end
end
