# frozen_string_literal: true

class CreateBills
  def initialize(amount, installments, due_day, enrollment_id)
    @amount = amount
    @installments = installments
    @due_day = due_day
    @enrollment_id = enrollment_id
  end

  def perform
    create_bills
  end

  private

  attr_reader :amount, :installments

  def create_bills
    @index = current_date.day > @due_day ? 1 : 0

    installments.times do
      Bill.create!(
        amount: bill_amount,
        due_date: due_date(@index),
        status: 'waiting',
        enrollment_id: @enrollment_id
      )

      @index += 1
    end
  end

  def current_date
    @current_date ||= Date.today
  end

  def bill_amount
    @bill_amount ||= amount / installments
  end

  def due_date(index)
    date = current_date.next_month(index)

    Date.new(date.year, date.month, day(date))
  end

  def day(date)
    Date.valid_date?(date.year, date.month, @due_day) ? @due_day : -1
  end
end
