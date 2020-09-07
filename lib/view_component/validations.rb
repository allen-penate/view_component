module ViewComponent
  module Validations
    extend ActiveSupport::Concern
    include ActiveModel::Validations

    def validate!(context = nil)
      return super.send(:validate!, context) if Rails.version.to_f >= 5.0
      valid?(context) || raise_standard_validation_error
    end

    protected

      def raise_standard_validation_error
        error_messages = "Validation failed: #{self.errors.full_messages.join(", ")}"
        raise(StandardError.new(error_messages))
      end

  end
end