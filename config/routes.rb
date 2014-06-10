Gorefi::Application.routes.draw do

  root :to => 'loans#new'

  resources :loans

end
