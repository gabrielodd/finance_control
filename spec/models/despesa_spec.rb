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
      # Add expectations for the created despesas in subsequent months
    end
  end
end