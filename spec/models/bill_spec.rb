require 'rails_helper'
require_relative '../../app/models/bill'

RSpec.describe Bill, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:enrollment) }
  end

  describe 'state machine transitions' do
    context 'when waiting' do
      subject { build(:bill, :waiting) }

      it 'can transition to paid' do
        expect { subject.mark_as_paid }.to change { subject.status }.from('waiting').to('paid')
      end

      context 'with past due date' do
        subject { build(:bill, :waiting, :overdue) }

        it 'can transition to pending' do
          expect { subject.mark_as_pending }.to change { subject.status }.from('waiting').to('pending')
        end
      end
    end

    context 'when pending' do
      subject { build(:bill, :pending) }

      it 'can transition to paid' do
        expect { subject.mark_as_paid }.to change { subject.status }.from('pending').to('paid')
      end
    end
  end
end
