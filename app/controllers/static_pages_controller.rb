class StaticPagesController < ApplicationController
  def home
  	@redirect_uri = "http://localhost:3000/redirect"
	@client = OAuth2::Client.new(ENV['PLANGRADE_APP_ID'], ENV['PLANGRADE_SECRET'], :site => "https://plangrade.com")
  end

  def redirect
  	redirect_uri = "http://localhost:3000/redirect"
  	client = OAuth2::Client.new(ENV['PLANGRADE_APP_ID'], ENV['PLANGRADE_SECRET'], :site => "https://plangrade.com")
	token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
	user_info = JSON.parse token.get('/api/v1/users/4').body
	@user = user_info["user"]
	companies_info = JSON.parse token.get('/api/v1/companies').body
	@companies = companies_info["companies"]
  end
end
