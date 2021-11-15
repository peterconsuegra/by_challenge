class Order < ApplicationRecord
  
  has_many :line_items
  
  def self.create!(parameters)
    
    parameters_hash = parameters.to_h
    array = parameters_hash[:line_items_attributes]
    
    #create order to get the id
    order = Order.new
    order.save!
    
    #set local variables
    at_least_one_line_item_was_saved = false
    taxes = 0
    subtotals = 0
    totals = 0
    
    array.each do |param|   
      #Security check if param is a valid hash {quantity: x, amount: y}
      regexp = /\{\s*quantity:\s*[0-9]+\s*,\s*amount:\s*[0-9]+\s*}/
      if regexp.match?(param)
        line_item = LineItem.new(eval(param))
        line_item.get_subtotal
        line_item.get_tax
        line_item.get_total
        line_item.order_id = order.id
        if line_item.save
          taxes += line_item.tax
          subtotals += line_item.subtotal
          totals += line_item.total
          at_least_one_line_item_was_saved = true
        end
      else
        logger.debug "Oops! invalid param"
        logger.debug param
      end
    end
    
    if at_least_one_line_item_was_saved
      #save order totals
      order.subtotal = subtotals
      order.tax = taxes
      order.total = totals
      order.save
    else
      #delete order if no line_items were saved
      order.destroy
    end
    
    return order
  end
  
  
  
  def self.update!(parameters)
    
    parameters_hash = parameters.to_h
    array = parameters_hash[:line_items_attributes]
    order = Order.find(parameters_hash[:id])
    
   # byebug
    
    #delete line_items
    order.line_items.destroy_all
    
    #set local variables
    taxes = 0
    subtotals = 0
    totals = 0
    
    array.each do |param|   
      #Security check if param is a valid hash
      regexp = /\{\s*quantity:\s*[0-9]+\s*,\s*amount:\s*[0-9]+\s*}/
      if regexp.match?(param)
        line_item = LineItem.new(eval(param))
        line_item.get_subtotal
        line_item.get_tax
        line_item.get_total
        line_item.order_id = order.id
        if line_item.save
          taxes += line_item.tax
          subtotals += line_item.subtotal
          totals += line_item.total
          at_least_one_line_item_was_saved = true
        end
      else
        logger.debug "Oops! invalid param"
        logger.debug param
      end
    end
    
    order.subtotal = subtotals
    order.tax = taxes
    order.total = totals
    order.save
    
    return order
  end
 
  
end
