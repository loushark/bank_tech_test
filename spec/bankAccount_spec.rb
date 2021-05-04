require 'BankAccount'

describe BankAccount do
  let(:test_account) { BankAccount.new("Client 1") }

  context 'when a new bankaccount is created' do
    it "has a name and a balance" do
      expect(test_account.name).to eq "Client 1"
      expect(test_account.balance).to eq 0
    end
  end

  describe '#deposit' do
    context 'when a desposit is made' do
      it 'saves the amount to the balance' do
        test_account.deposit(10)
        expect(test_account.balance).to eq 10
      end
    end
  end

  describe '#withdraw' do
    context 'when a withdrawal is made' do
      it 'minuses the amount from the balance' do
        test_account.deposit(10)
        test_account.withdraw(5)
        expect(test_account.balance).to eq 5
      end
    end
  end
end
