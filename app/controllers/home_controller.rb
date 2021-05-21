class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] #si no hay una sesion existente, redirecciona al usuario a la autenticacion
  def index

  end
end