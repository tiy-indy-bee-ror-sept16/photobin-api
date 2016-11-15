class ChargesController < ApplicationController

  def create
    @photo = Photo.find(params[:id])
    @amount = 500
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'One awesome photo!',
      :currency    => 'usd'
    )

    render json: ["Successfully charged"]

    rescue Stripe::CardError => e
      render json: [e.message], status: :unprocessable_entity
  end

end
