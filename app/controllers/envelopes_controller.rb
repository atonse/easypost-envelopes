class EnvelopesController < ApplicationController
  def show
  end

  def verify
    EasyPost.api_key = 'YRVBWs_KJk3qmXvv_N-xAg'

    EasyPost::Address.create(
      :name => 'Dirk Diggler',
      :street1 => '300 Granelli Ave',
      :city => 'Half Moon Bay',
      :state => 'CA',
      :zip => '94019',
      :country => 'US',
      :email => 'dirk_d@gmail.com'
    )

  end
end
