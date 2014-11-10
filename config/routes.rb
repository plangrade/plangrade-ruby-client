PlangradeClient::Application.routes.draw do
  root 'static_pages#home'
  get  '/auth/:provider/callback' => 'static_pages#redirect'
end
