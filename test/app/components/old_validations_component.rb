# frozen_string_literal: true
require 'view_component/validations'
# TODO: Remove in v3.0.0
class OldValidationsComponent < ViewComponent::Base
  include ViewComponent::Validations

  validates :content, presence: true

  def before_render_check
    validate!
  end
end
