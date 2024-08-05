RSpec.describe Student, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
  end
end
