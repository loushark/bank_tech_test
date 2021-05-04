require 'statement'

describe Statement do
  let(:test_statement) { Statement.new }

  context 'when a new statement is created' do
    it "has a history" do
      expect(test_statement.account_history).to eq []
    end
  end

end
