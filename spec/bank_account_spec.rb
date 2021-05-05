# frozen_string_literal: true

require 'bank_account'

describe BankAccount do
  let(:test_account) { BankAccount.new('Client 1') }
  let(:mock_statement) do
    double 'Statement',
           account_history: [{ "Withdraw": 0, "Deposit": 25, "Balance": 25 },
                             { "Withdraw": 10, "Deposit": 0, "Balance": 15 }]
  end

  context 'when a new bankaccount is created' do
    it 'has a name and a balance' do
      expect(test_account.name).to eq 'Client 1'
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

  describe '#save_deposit_to_statement' do
    context 'when a deposit is made' do
      it 'saves it to the history' do
        expect(test_account.deposit(10)).to eq 'Deposit amount saved to statement'
      end
    end
  end

  describe '#save_deposit_to_statement' do
    context 'when a withdrawal is made' do
      it 'saves it to the history' do
        expect(test_account.withdraw(5)).to eq 'Withdrawal amount saved to statement'
      end
    end
  end

  describe '#print_statement' do
    context 'when a statement is requested' do
      before do
        allow(Statement).to receive(:new).and_return(mock_statement)
      end

      it 'prints a statement containing the account history' do
        allow(test_account).to receive(:print_statement).and_return(mock_statement.account_history)
        expect(test_account.print_statement).to eq mock_statement.account_history
      end

      it 'confirms the statement printing was successul' do
        allow(mock_statement).to receive(:format_statement)
        expect(test_account.print_statement).to eq 'Successfully printed statement'
      end
    end
  end
end
