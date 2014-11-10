class StaticPagesController < ApplicationController
  require 'plangrade'

  def home
  end

  def redirect
  	auth = request.env["omniauth.auth"]
  	token = auth["credentials"]["token"]
  	@refresh_token = auth["credentials"]["refresh_token"]
  	Plangrade.configure do |p|
  	  p.access_token = token
	end
	@user = Plangrade.current_user
	@companies = Plangrade.all_companies
	@participants = Plangrade.all_participants(:company_id => 2)
  end
end
