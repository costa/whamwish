class RegistersController < ApplicationController

  respond_to :json, :except => :app

  TIMESTAMP_PARAMS = %i[created_at updated_at]
  UPDATE_PARAMS = %i[title subtitle bg_color]
  CREATE_PARAMS = UPDATE_PARAMS + %i[key]

  def app
  end

  def create
    register = scope.create create_register_params
    respond_with register  # NOTE by default: , :json => register
  end

  def update
    raise "Nonsense"  if params.delete(:id) != params[:key]
    register = scope.update params.delete(:key), update_register_params
    respond_with register, :json => register  # NOTE not by default
  end

  private

  def scope
    Register
  end

  def create_register_params
    params.permit CREATE_PARAMS
  end

  def update_register_params
    params.
      except(*TIMESTAMP_PARAMS).  # XXX a timestamp consistency check?
      permit UPDATE_PARAMS
  end

end
