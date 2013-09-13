Easypost::Application.routes.draw do
  root :to => 'application#index'

  match '/verify', to: 'easy_post#verify', via: :post
  match '/parcel', to: 'easy_post#parcel', via: :post
  match '/rates', to: 'easy_post#rates', via: :get
  match '/shipment', to: 'easy_post#shipment', via: :post
  match '/buy', to: 'easy_post#buy', via: :post
end
