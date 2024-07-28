class Student < ApplicationRecord
  PAYMENT_METHODS = %w[credit_card boleto].freeze

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :payment_method, presence: true, inclusion: { in: PAYMENT_METHODS }

  before_validation :validate!

  private

  def validate!
    raise ArgumentError, "CPF informado é inválido" unless valid_cpf?
  end

  def valid_cpf?
    verifying_digit(9, 10) == formated_cpf[-2] && verifying_digit(10, 11) == formated_cpf[-1]
  end

  def formated_cpf
    @formated_cpf ||= cpf.gsub('.', '').gsub('-', '').chars.map{ |char| char.to_i }
  end

  def verifying_digit(qtd_digt, aux)
    result = 0

    formated_cpf.slice(0, qtd_digt).each do |digit|
      result += digit * aux
      aux -= 1
    end

    (result % 11) < 2 ? 0 : 11 - (result % 11)
  end
end
