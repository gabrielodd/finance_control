require 'rails_helper'

RSpec.describe DespesaService do
  let(:user) { create(:user) }
  let(:categoria) { create(:categoria, user: user) }

  let(:valid_params) do
    {
      descricao: ["Test Expense"],
      valor: [100.0],
      date: [Date.today],
      repeating: [nil],
      categoria_id: [categoria.id]
    }
  end

  let(:repeating_params) do
    {
      descricao: ["Repeating Expense"],
      valor: [200.0],
      date: [Date.today],
      repeating: ["0", "1", "x"],
      categoria_id: [categoria.id]
    }
  end

  # let(:invalid_params) do
  #   {
  #     descricao: [""],
  #     valor: [nil],
  #     date: [Date.today],
  #     repeating: [nil],
  #     categoria_id: [categoria.id]
  #   }
  # end

  describe "#call" do
    context "when given valid parameters" do
      it "creates a despesa record successfully" do
        service = DespesaService.new(valid_params, user.id)
        result = service.call

        expect(result[:created_despesas].size).to eq(1)
        expect(result[:errors]).to be_empty
        expect(result[:created_despesas].first.descricao).to eq("Test Expense")
        expect(result[:created_despesas].first.valor).to eq(100.0)
      end

      it "creates a repeating despesa record with delay" do
        allow(Despesa).to receive(:delay).and_return(double("Delayed", create_every_month: true))
        
        service = DespesaService.new(repeating_params, user.id)
        result = service.call

        expect(result[:created_despesas].size).to eq(1)
        expect(result[:errors]).to be_empty
        expect(Despesa).to have_received(:delay).with(run_at: Date.today + 1.month)
      end
    end

    # context "when given invalid parameters" do
    #   it "does not create a despesa record and returns errors" do
    #     service = DespesaService.new(invalid_params, user.id)
    #     result = service.call

    #     expect(result[:created_despesas]).to be_empty
    #     expect(result[:errors].size).to eq(1)
    #     expect(result[:errors].first).to include("Descricao can't be blank")
    #     expect(result[:errors].first).to include("Valor can't be blank")
    #   end
    # end

    context "when there are multiple despesas" do
      it "creates multiple despesa records" do
        multi_params = {
          descricao: ["Expense 1", "Expense 2"],
          valor: [150.0, 250.0],
          date: [Date.today, Date.today + 1.day],
          repeating: [nil, "x"],
          categoria_id: [categoria.id, categoria.id]
        }

        service = DespesaService.new(multi_params, user.id)
        result = service.call

        expect(result[:created_despesas].size).to eq(2)
        expect(result[:created_despesas].map(&:descricao)).to contain_exactly("Expense 1", "Expense 2")
        expect(result[:errors]).to be_empty
      end
    end
  end
end