require 'rails_helper'

RSpec.describe "Create page", type: :feature do
  context "User creates one expense" do
    let!(:user) { User.create(email: 'test@example.com', password: 'password123') }
    let!(:category) { Categoria.create(name: 'Category1', user_id: user.id) }

    it "User creates one non repeating expense", js: true do
      login_as(user)

      visit new_despesa_path

      fill_in 'despesa_descricao', with: 'Sample Despesa'
      fill_in 'despesa_valor', with: '100.50'
      fill_in 'despesa_date', with: Date.today
      select 'Category1', from: 'despesa_categoria_id'

      click_button 'Save'

      expect(page).to have_content('Expenses were successfully created')
      expect(Despesa.last.valor).to eq(100.50)
    end

    it "User creates one non repeating expense", js: true do
      login_as(user)

      visit new_despesa_path

      fill_in 'despesa_descricao', with: 'Sample Despesa'
      fill_in 'despesa_valor', with: '100.50'
      fill_in 'despesa_date', with: Date.today
      select 'Category1', from: 'despesa_categoria_id'

      click_button 'Add More'

      within all('.fields').last do
        fill_in 'despesa_descricao', with: 'Second Despesa'
        # fill_in 'despesa_valor', with: '200.75'
        # fill_in 'despesa_date', with: Date.today
        select 'Category1', from: 'despesa_categoria_id'
      end

      click_button 'Save'

      expect(page).to have_content('Expenses were successfully created')
      expect(Despesa.first.valor).to eq(100.50)
      # expect(Despesa.last.valor).to eq(200.75)

      expect(Despesa.count).to eq(2)
    end
  end
end