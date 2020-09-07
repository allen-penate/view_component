# frozen_string_literal: true
require 'view_component/validations'

class ValidationsComponent < ViewComponent::Base
  include ViewComponent::Validations

  validates :content, presence: true

  def before_render
    validate!
  end
end
