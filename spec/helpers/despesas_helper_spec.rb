require 'rails_helper'

RSpec.describe DespesasHelper, type: :helper do
  describe '#positive_negative_style' do
    it 'returns red style for positive values' do
      expect(helper.positive_negative_style(10)).to eq('color:red; font-size:20px;')
    end

    it 'returns green style for negative or zero values' do
      expect(helper.positive_negative_style(-10)).to eq('color:green; font-size:20px;')
      expect(helper.positive_negative_style(0)).to eq('color:green; font-size:20px;')
    end
  end

  describe '#formatted_date' do
    it 'formats the date in the expected format' do
      date = Date.new(2024, 11, 17)
      expect(helper.formatted_date(date)).to eq('Nov 17, 2024')
    end
  end

  describe '#formatted_decimal' do
    context 'when locale is :en' do
      before do
        I18n.locale = :en
      end

      it 'formats the decimal value with English locale settings' do
        expect(helper.formatted_decimal(1234.5678)).to eq('1,234.57')
      end

      it 'formats zero correctly in English locale' do
        expect(helper.formatted_decimal(0)).to eq('0.00')
      end
    end

    context 'when locale is :pt-BR' do
      before do
        I18n.locale = :'pt-BR'
      end
  
      it 'formats the decimal value with Brazilian Portuguese locale settings' do
        expect(helper.formatted_decimal(1234.5678)).to eq('1.234,57')
      end
  
      it 'formats zero correctly in Brazilian Portuguese locale' do
        expect(helper.formatted_decimal(0)).to eq('0,00')
      end
    end
  end

  describe '#category_options' do
    it 'returns an array of categories for the current user' do
      user = create(:user)
      categoria1 = create(:categoria, name: 'Food', user: user)
      categoria2 = create(:categoria, name: 'Utilities', user: user)

      allow(helper).to receive(:current_user).and_return(user)

      expect(helper.category_options).to eq([['Food', categoria1.id], ['Utilities', categoria2.id]])
    end
  end
end