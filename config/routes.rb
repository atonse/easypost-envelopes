Easypost::Application.routes.draw do
  root :to => 'envelopes#show'

  match '/verify', to: 'envelopes#verify'
end
