require 'rails_helper'
require_relative '../../app/models/student'

RSpec.describe Student, type: :model do
  let!(:student) { build(:student) }

  describe 'relationships' do
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
  end
end

