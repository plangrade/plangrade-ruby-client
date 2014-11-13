class StaticPagesController < ApplicationController
  require 'plangrade'

  def home
  end

  def redirect
  	# interpret the omniauth response to identify the token and refresh token
  	auth = request.env["omniauth.auth"]
  	token = auth["credentials"]["token"]
  	@refresh_token = auth["credentials"]["refresh_token"]

  	# configure plangrade with the returned token
  	Plangrade.configure do |p|
  	  p.access_token = token
    end

    # get the current user's info
  	@user = Plangrade::Resources::User.current_user

  	# get all of the current user's companies
  	@companies = Plangrade::Resources::Company.all

  	# set participants to nil
  	@participants = nil
  end

  def participants
  	# create a plangrade oauth client and refresh the token
  	plangrade_client = Plangrade::OAuth2Client.new(ENV['PLANGRADE_CLIENT_ID'], ENV['PLANGRADE_CLIENT_SECRET'])
  	token_pair = JSON.parse plangrade_client.refresh!(params[:refresh_token]).body
  	token = token_pair["access_token"]
  	@refresh_token = token_pair["refresh_token"]

  	# configure plangrade with the returned token
  	Plangrade.configure do |p|
  	  p.access_token = token
  	end

  	# get the current user's info
	@user = Plangrade.current_user

	# get all of the current user's companies
	@companies = Plangrade.all_companies

  	# get all of the requested company's participants
  	id = params[:company_id]
  	id = id.to_i if !id.is_a? Integer
  	@participants = Plangrade.all_participants(:company_id => id)

  	respond_to do |format|
      format.html
      format.js
    end
  end
end
