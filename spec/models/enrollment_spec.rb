RSpec.describe Enrollment, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to have_many(:bills) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }

    it { is_expected.to validate_presence_of(:installments) }
    it { is_expected.to validate_numericality_of(:installments).is_greater_than(1) }

    it { is_expected.to validate_presence_of(:due_day) }
    it { is_expected.to validate_numericality_of(:due_day).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(31) }
  end
end
