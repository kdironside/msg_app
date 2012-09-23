MsgApp::Application.routes.draw do

  root :to => 'home#index'

  resources :users do
    resources :conversations 
  end
  
  resources :conversations do
    resources :messages
  end
  
  
end