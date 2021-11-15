require "rails_helper"
require 'json'

RSpec.describe "Order management", :type => :request do
  
  it "create and update a order with all the parameters ok" do
    
    headers = { "ACCEPT" => "application/json" }
    post "/orders", :params => {"order"=>{"line_items_attributes"=>["{quantity: 5, amount:10}", "{quantity:3, amount:10}", "{quantity:5, amount:10}"]}}, :headers => headers
    object = JSON.parse(response.body, object_class: OpenStruct)
    #byebug
    expect(object.total).to eq("140.4")
    expect(object.tax).to eq("10.4")
    expect(object.subtotal).to eq("130.0")
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:created)
    
    
    headers = { "ACCEPT" => "application/json" }
    patch "/orders", :params => {"order"=>{"line_items_attributes"=>["{quantity:1, amount:10}", "{quantity:3, amount:100}", "{quantity:5, amount:100}"], "id"=>"1"}}, :headers => headers
    object = JSON.parse(response.body, object_class: OpenStruct)
    #byebug
    expect(object.total).to eq("874.8")
    expect(object.tax).to eq("64.8")
    expect(object.subtotal).to eq("810.0")
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:ok)
    
  end
  
  
  #Edge cases
  
  it "create and update an order with the first line_items_attributes wrong parameter" do
    
    #Create and update the order with the correct line_items attributes
    headers = { "ACCEPT" => "application/json" }
    post "/orders", :params => {"order"=>{"line_items_attributes"=>["{quantity5, amount:10}", "{quantity:3, amount:10}", "{quantity:5, amount:10}"]}}, :headers => headers
    object = JSON.parse(response.body, object_class: OpenStruct)
    #byebug
    expect(object.total).to eq("86.4")
    expect(object.tax).to eq("6.4")
    expect(object.subtotal).to eq("80.0")
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:created)
    
    
    headers = { "ACCEPT" => "application/json" }
    patch "/orders", :params => {"order"=>{"line_items_attributes"=>["{quantity1, amount:10}", "{quantity:3, amount:100}", "{quantity:5, amount:100}"], "id"=>"1"}}, :headers => headers
    object = JSON.parse(response.body, object_class: OpenStruct)
    #byebug
    expect(object.total).to eq("864.0")
    expect(object.tax).to eq("64.0")
    expect(object.subtotal).to eq("800.0")
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:ok)
    
  end
  
  it "create an order with all wrong line_items_attributes parameters" do
    
    #don't create the order
    headers = { "ACCEPT" => "application/json" }
    post "/orders", :params => {"order"=>{"line_items_attributes"=>["{quantity5, amount:10}", "{quantity3, amount:10}", "{quantity5, amount:10}"]}}, :headers => headers
    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:unprocessable_entity)
    
  end
  
  
end