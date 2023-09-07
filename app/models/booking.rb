class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service
  belongs_to :merchant

  before_create :generate_random_receipt_number

  def generate_random_receipt_number
    prefix = "123"
    random_suffix = rand(100_000).to_s.rjust(8, '0') # Generates a random 8-digit number
    self.receipt = "#{prefix}#{random_suffix}"
  end
  

  # def set_default_values
  #   # upcoming defaults to true
  #   self.upcoming = true if upcoming.nil?

  #   # cancelled and completed default to false
  #   self.cancelled = false if cancelled.nil?
  #   self.completed = false if completed.nil?
  # end

end
