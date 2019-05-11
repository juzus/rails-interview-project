# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  it { is_expected.to rescue_from(ApplicationController::TenantAuthorizationError).with(:handle_invalid_tenant) }
end
