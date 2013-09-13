class EasyPostController < ApplicationController
  def verify
    begin
      address = EasyPost::Address.create(params.slice(:name, :street1, :street2, :city, :state, :zip, :country))
      verified_address = address.verify()
      render json: verified_address
    rescue EasyPost::Error => ex
      render json: { message: ex.message }
    end
  end

  def parcel
    parcel = EasyPost::Parcel.create(params.slice(:weight, :predefined_package))
    render json: parcel
  end

  def rates
    shipment = EasyPost::Shipment.retrieve(params[:shipment_id])

    render json: shipment.get_rates
  end

  def shipment
    shipment = EasyPost::Shipment.create(
      from_address: EasyPost::Address.retrieve(params[:from_address_id]),
      to_address: EasyPost::Address.retrieve(params[:to_address_id]),
      parcel: EasyPost::Parcel.retrieve(params[:parcel_id])
    )

    render json: shipment
  end

  def buy
    shipment = EasyPost::Shipment.retrieve(params[:shipment_id])
    rate = EasyPost::Rate.retrieve(params[:rate_id])

    postage = shipment.buy( rate: rate )

    render json: postage
  end
end
