class Student < ApplicationRecord
  PAYMENT_METHODS = %w[credit_card boleto].freeze

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :payment_method, presence: true, inclusion: { in: PAYMENT_METHODS }

  before_validation :cpf_is_valid?

  private

  def cpf_is_valid?
    
  end

  def format_cpf
    array.gsub('.', '').gsub('-', '').chars
  end


end
