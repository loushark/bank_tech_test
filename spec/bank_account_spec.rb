# frozen_string_literal: true

require 'bank_account'

describe BankAccount do
  let(:test_account) { BankAccount.new('Client 1', mock_statement) }
  let(:mock_statement) { double 'Statement', format_statement: nil }

  describe '#deposit' do
    before do
      allow(mock_statement).to receive(:save_deposit_history)
      allow(mock_statement).to receive(:save_withdraw_history)
    end

    context 'when a deposit is made' do
      it 'returns a confirmation' do
        expect(test_account.deposit(10)).to eq 'Deposit amount saved to statement'
      end
    end

    context 'when a withdrawal is made' do
      it 'returns a confirmation' do
        expect(test_account.withdraw(10)).to eq 'Withdrawal amount saved to statement'
      end
    end
  end

  describe '#print_statement' do
    context 'when a statement is requested' do
      it 'formats a statement' do
        test_account.print_statement
        expect(mock_statement).to have_received(:format_statement)
      end

      it 'confirms the statement printing was successful' do
        expect(test_account.print_statement).to eq 'Successfully printed statement'
      end
    end
  end
end
