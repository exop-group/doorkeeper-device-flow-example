# frozen_string_literal: true

class ApiController < ApplicationController
  before_action :doorkeeper_authorize!
  respond_to :json

  # GET /me.json
  def me
    respond_with current_resource_owner
  end

  private

  # @return [User]
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id)
  end
end
