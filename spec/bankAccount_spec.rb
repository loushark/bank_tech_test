require 'BankAccount'

describe BankAccount do
  let(:test_account) { BankAccount.new("Client 1") }

  context 'creates a new bankaccount' do
    it "has a name and a balance" do
      expect(test_account.name).to eq "Client 1"
      expect(test_account.balance).to eq 0
    end
  end
end
