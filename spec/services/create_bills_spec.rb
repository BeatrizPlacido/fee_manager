RSpec.describe CreateBills do
  describe '.perform' do
    let(:amount) { 1200 }
    let(:installments) { 6 }
    let(:due_day) { 31 }
    let(:enrollment) do
      Enrollment.create!(
        amount: 1200,
        installments: 6,
        due_day: 31,
        student_id: student.id
      )
    end
    let(:student) do
      Student.create!(
        name: 'Student Name',
        cpf: '476.623.748.07',
        payment_method: 'credit_card',
      )
    end

    subject { described_class.new(amount, installments, due_day, enrollment.id).perform }

    context 'when params are invalid' do
      context 'with invalid full_value' do
        let (:amount) { 0 }

        it do
          expect { subject }.to raise_error(ArgumentError, 'amount must be valid')
        end
      end

      context 'with invalid installments' do
        let (:installments) { 0 }

        it do
          expect { subject }.to raise_error(ArgumentError, 'installments must be valid')
        end
      end

      context 'with invalid due_day' do
        let (:due_day) { 0 }

        it do
          expect { subject }.to raise_error(ArgumentError, 'due_day must be valid')
        end
      end
    end

    context 'when params are valid' do
      it 'bills are created with valid due date' do
        bills = Bill.where(enrollment_id: enrollment.id)

        expect(bills.count).to eq(6)

        bills.each do |bill|
          expect(bill.due_date).not_to be_nil
          expect(bill.due_date).to be_a(Date)
        end
      end
    end
  end
end
