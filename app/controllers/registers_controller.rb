class RegistersController < ApplicationController

  respond_to :json, :except => :app

  before_filter :remove_id_param  # XXX https://github.com/jashkenas/backbone/issues/302#issuecomment-69498852

  def app
  end

  def create
    respond_with scope.create register_params
  end


  private

  def scope
    Register
  end

  def register_params
    params.permit(:key, :title, :subtitle, :bg_color)
  end

  def remove_id_param
    params.delete :id
  end

end
