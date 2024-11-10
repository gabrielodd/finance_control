require 'rails_helper'

RSpec.describe UserConfiguration, type: :model do
  let(:user) { create(:user) }
  let(:user_configuration) { create(:user_configuration, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe "#panel_color" do
    context "when panel_color is not set" do
      it "returns the default panel color 'bg-2'" do
        expect(user_configuration.panel_color).to eq("bg-2")
      end
    end

    context "when panel_color is set" do
      it "returns the assigned panel color" do
        user_configuration.panel_color = "bg-3"
        expect(user_configuration.panel_color).to eq("bg-3")
      end
    end
  end
end
