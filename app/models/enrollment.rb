class Enrollment < ApplicationRecord
  has_many :bills, dependent: :destroy

  belongs_to :student

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :installments, presence: true, numericality: { greater_than: 1 }
  validates :due_day, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }

  after_create :create_bills

  private

  def create_bills
    CreateBills.new(amount, installments, due_day, id).perform
  end
end
