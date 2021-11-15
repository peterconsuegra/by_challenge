class LineItem < ApplicationRecord
  
  belongs_to :order
  
  validates :quantity, presence: true
  validates :amount, presence: true
  validates :subtotal, presence: true
  validates :tax, presence: true
  validates :total, presence: true
  
  def get_subtotal
    #quantity by amount
    self.subtotal = self.quantity * self.amount
  end
  
  def get_tax
    #8% of the subtotal
    self.tax = self.subtotal * 0.08
  end
  
  def get_total
    #subtotal + tax
    self.total = self.subtotal + self.tax
  end
  
end
