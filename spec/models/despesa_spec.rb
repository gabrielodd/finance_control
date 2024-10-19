require 'rails_helper'

RSpec.describe Despesa, type: :model do
  let(:user) { create(:user) } 

  describe 'associations' do
    it { should belong_to(:categoria) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:user) }
  end

  describe 'scopes' do
    it 'should scope per_user' do
      despesa = create(:despesa, user: user)
      expect(Despesa.per_user(user.id)).to include(despesa)
    end
  end

  describe 'methods' do
    it 'should return month name' do
      despesa = build(:despesa, date: Date.new(2023, 1, 1))
      expect(despesa.mes).to eq('January')
    end

    it 'should return month and year' do
      despesa = build(:despesa, date: Date.new(2023, 1, 1))
      expect(despesa.mes_ano).to eq('January 2023')
    end

    it 'should return year' do
      despesa = build(:despesa, date: Date.new(2023, 1, 1))
      expect(despesa.ano).to eq('2023')
    end

    describe '.total_spendings_current_month_from_user' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user, email: 'abc@gmail.com') }
      let(:current_date) { Date.current }
      let(:last_month) { 1.month.ago }
  
      before do
        # Create despesas for the current month for the specified user
        create(:despesa, user: user, date: current_date.beginning_of_month + 1.day, valor: 100.0)
        create(:despesa, user: user, date: current_date.end_of_month - 1.day, valor: 200.0)
  
        # Create despesas for another user for the current month
        create(:despesa, user: other_user, date: current_date.beginning_of_month + 1.day, valor: 500.0)
  
        # Create despesas for the specified user for the previous month
        create(:despesa, user: user, date: last_month, valor: 400.0)
      end
  
      it 'returns the total spendings for the current month for the user' do
        total = Despesa.total_spendings_current_month_from_user(user.id, current_date)
        expect(total).to eq(300.0) # 100.0 + 200.0
      end
  
      it 'does not include spendings from other users' do
        total = Despesa.total_spendings_current_month_from_user(user.id, current_date)
        expect(total).to_not eq(500.0) # Other user's despesas should not be included
      end
  
      it 'does not include spendings from previous months' do
        total = Despesa.total_spendings_current_month_from_user(user.id, current_date)
        expect(total).to_not eq(400.0) # Previous month's despesas should not be included
      end
  
      it 'returns 0 if there are no spendings for the user in the current month' do
        total = Despesa.total_spendings_current_month_from_user(other_user.id, last_month)
        expect(total).to eq(0.0)
      end
    end
  end

  describe 'callbacks' do
    it 'should set default valor before validation' do
      despesa = build(:despesa, valor: nil)
      despesa.valid?
      expect(despesa.valor).to eq(0)
    end
  end

  describe 'class methods' do
    it 'should create every month' do
      despesa = create(:despesa, user: user)
      Despesa.create_every_month(despesa.id, user.id)
    end
  end
end