Easypost::Application.routes.draw do
  root :to => 'application#index'

  match '/verify', to: 'easy_post#verify', via: :post
  match '/parcel', to: 'easy_post#parcel', via: :post
  match '/rates', to: 'easy_post#rates', via: :get
  match '/buy', to: 'easy_post#buy', via: :post

  match '/shipment', to: 'easy_post#shipment', via: :post
  match '/shipment/:id/stamp', to: 'easy_post#stamp', via: :get
  match '/shipment/:id/barcode', to: 'easy_post#stamp', via: :get

end
