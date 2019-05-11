# frozen_string_literal: true

class ApplicationController < ActionController::Base
  class TenantAuthorizationError < StandardError
  end

  include Rescuable

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from TenantAuthorizationError, with: :handle_invalid_tenant
end
