Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  post "orders", to: "orders#create"
  patch "orders", to: "orders#update"
  
  post "bands", to: "orders#bands"
  
end
