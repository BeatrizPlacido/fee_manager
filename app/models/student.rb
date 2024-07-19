class Student < ApplicationRecord
  PAYMENT_METHODS = %w[credit_card boleto].freeze

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :payment_method, presence: true, inclusion: { in: PAYMENT_METHODS }

  before_validation :cpf_is_valid?

  private

  def cpf_is_valid?
    first_verifying_digit(format_cpf) == format_cpf[-2] && second_verifying_digit(format_cpf) == format_cpf[-1]
  end

  def format_cpf
    @format_cpf ||= cpf.gsub('.', '').gsub('-', '').chars.map{ |char| char.to_i }
  end

  def first_verifying_digit(format_cpf)
    aux = 10
    result = 0

    format_cpf.slice(0, 9).each do |digit|
      result += digit * aux
      aux -= 1
    end

    (result % 11) < 2 ? 0 : 11 - (result % 11)
  end

  def second_verifying_digit(format_cpf)
    aux = 11
    result = 0

    format_cpf.slice(0, 10).each do |digit|
      result += digit * aux
      aux -= 1
    end

    (result % 11) < 2 ? 0 : 11 - (result % 11)
  end
end
