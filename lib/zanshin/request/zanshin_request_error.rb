# frozen_string_literal: true

module Zanshin
  module SDK
    module Request
      # Zanshin SDK request ZanshinError
      class ZanshinError < StandardError
        attr_reader :code, :body

        # Initialize a new Zanshin Error
        # @overload initialize(code, body)
        #   @param code [String] of the Error
        #   @param body [String] message of the error
        def initialize(code, body)
          @code = code
          @body = body
          super("Error [#{code}] #{body}")
        end
      end
    end
  end
end
