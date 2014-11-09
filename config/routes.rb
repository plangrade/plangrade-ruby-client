PlangradeClient::Application.routes.draw do
  root 'static_pages#home'
  get  'redirect' => 'static_pages#redirect'
end
