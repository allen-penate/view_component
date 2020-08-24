# frozen_string_literal: true

module ViewComponent
  module TestHelpers
    begin
      require "capybara/minitest"
      include Capybara::Minitest::Assertions

      def page
        Capybara::Node::Simple.new(@rendered_component)
      end

      def refute_component_rendered
        assert_no_selector("body")
      end
    rescue LoadError
      warn "WARNING in `ViewComponent::TestHelpers`: You must add `capybara` to your Gemfile to use Capybara assertions." if ENV["DEBUG"]
    end

    attr_reader :rendered_component

    def render_inline(component, **args, &block)
      @rendered_component =
        if Rails.version.to_f >= 6.1
          controller.view_context.render(component, args, &block)
        else
          controller.view_context.render_component(component, &block)
        end

      Nokogiri::HTML.fragment(@rendered_component)
    end

    def controller
      @controller ||= Base.test_controller.constantize.new.tap { |c| c.request = request }.extend(Rails.application.routes.url_helpers)
    end

    def request
      @request ||= (Rails.version.to_f >= 5.0) ? ActionDispatch::TestRequest.create : ActionDispatch::TestRequest.new
    end

    def with_variant(variant)
      old_variants = controller.view_context.lookup_context.variants

      controller.view_context.lookup_context.variants = variant
      yield
      controller.view_context.lookup_context.variants = old_variants
    end
  end
end
