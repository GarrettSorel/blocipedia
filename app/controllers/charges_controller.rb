class ChargesController < ApplicationController
    

def new
  @amount = 1500     
  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "BigMoney Membership - #{current_user.email}",
    amount: @amount
  }
end

def create
  # Creates a Stripe Customer object, for associating
  # with the charge
  @amount = 1500
  
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
   )
   
   current_user.stripe_id = customer.id
 
  # Where the real magic happens
  charge = Stripe::Charge.create(
    customer: customer.id, 
    amount: @amount,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
  )
 
  flash[:notice] = "Your account has been successfully upgraded."
  current_user.role = :premium
  current_user.save!
  
  redirect_to wikis_path
 
  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    if customer.delete
      flash[:notice] = "\"#{current_user.email}\" was downgraded to standard successfully.\nAll associated Wiki's have been marked as PUBLIC."
      current_user.role = 'standard'
      current_user.save!

      wikis = current_user.wikis
      wikis.each do |wiki|
        if wiki.private
          wiki.private = false
          wiki.save!
        end
      end

      redirect_to new_charge_path
    else
      flash.now[:alert] = "There was an error downgrading the user."
      redirect_to new_charge_path
    end
  end
end