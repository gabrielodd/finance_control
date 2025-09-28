require 'rails_helper'

RSpec.describe DespesaPresenter, type: :presenter do
  let(:user) { create(:user) }
  let(:params) { {} }
  let(:despesa_presenter) { described_class.new(user, params) }
  let!(:despesa1) { create(:despesa, user: user, date: Date.current) }
  let!(:despesa2) { create(:despesa, user: user, date: 1.month.ago, valor: 300.0) }
  let!(:despesa3) { create(:despesa, user: user, date: 1.year.ago, valor: 500.0) }

  describe '#despesas' do
    it 'retrieves despesas for the current user' do
      expect(despesa_presenter.despesas).to match_array([despesa1, despesa2, despesa3])
    end

    context 'when filtering by year' do
      let(:params) { { year: 1.year.ago.to_s } }

      it 'retrieves despesas for the specified year' do
        expect(despesa_presenter.despesas).to contain_exactly(despesa3)
      end
    end
  end

  describe '#newest_record' do
    context 'when a despesa has just been updated' do 
      it 'returns the most recently updated' do
        despesa1.update(descricao: "abc")
        expect(despesa_presenter.newest_record).to eq(despesa1)
      end
    end

    context 'when a despesa has just been created' do 
      let!(:despesa4) {create(:despesa, user: user)}

      it 'returns the most recently created' do
        expect(despesa_presenter.newest_record).to eq(despesa4)
      end
    end
  end

  describe '#despesas_grouped_by_month' do
    it 'groups despesas by month' do
      grouped = despesa_presenter.despesas_grouped_by_month
      expect(grouped.keys).to contain_exactly(despesa1.mes, despesa2.mes)
    end
  end

  describe '#despesas_grouped_by_year' do
    it 'groups despesas by year' do
      grouped = despesa_presenter.despesas_grouped_by_year
      years = [despesa1.ano, despesa2.ano, despesa3.ano].uniq
      expect(grouped.keys).to eq(years)
    end
  end

  describe '#total_current_month' do
    it 'calculates total spendings for the current month' do
      expect(despesa_presenter.total_current_month).to eq(100)
    end
  end

  describe '#total_last_month' do
    it 'calculates total spendings for last month' do
      expect(despesa_presenter.total_last_month).to eq(300)
    end
  end

  describe '#difference' do
    it 'calculates the difference between this month and last month' do
      expect(despesa_presenter.difference).to eq(-200)
    end
  end

  describe '#jobs' do
    let(:job1) do
      instance_double(
        "Delayed::Job",
        id: 1,
        run_at: Time.current,
        handler: "--- !ruby/object:Delayed::PerformableMethod\nargs:\n- #{user.id}"
      )
    end

    let(:job2) do
      instance_double(
        "Delayed::Job",
        id: 2,
        run_at: Time.current,
        handler: "--- !ruby/object:Delayed::PerformableMethod\nargs:\n- #{user.id + 1}"
      )
    end

    before do
      allow(Delayed::Job).to receive(:all).and_return([job1, job2])
    end

    it 'returns only the jobs related to the user' do
      result = despesa_presenter.jobs
      expect(result.map { |h| h[:job_id] }).to eq([1])
    end
  end

  describe '#years_with_despesas' do
    it 'returns distinct years where the user has despesas' do
      expect(despesa_presenter.years_with_despesas).to include(despesa1.ano.to_i, despesa2.ano.to_i, despesa3.ano.to_i)
    end
  end
end