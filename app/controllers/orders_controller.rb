class OrdersController < ApplicationController
  
  def create
     logger.debug "enter into create"
     begin
       Order.transaction do
         order = Order.create!(permitted_params)
         if order.persisted?
           render json: order, status: :created
         else
            logger.debug "No creo orden"
           render json: order, status: :unprocessable_entity
         end
       end
     rescue ActiveRecord::RecordInvalid => exception
       order = {
         error: {
           status: :unprocessable_entity,
           message: exception
         }
       }
       render json: order
     end
   end
  

  def update
    begin
      Order.transaction do
       order = Order.update!(permitted_params) 
       render json: order, status: :ok
      end
    rescue ActiveRecord::RecordInvalid => exception
      order = {
        error: {
          status: :unprocessable_entity,
          message: exception
        }
      }
      render json: order
    end
  end
  
  private
  
  def permitted_params
      params.require(:order).permit(:id, :line_items_attributes => [])
  end
  
end
