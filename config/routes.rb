Gorefi::Application.routes.draw do

  root :to => 'loans#new'
  put '/loans/:id/calculator', to: 'loans#calculator', as: 'calculator'
  resources :loans


end
