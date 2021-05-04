# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:test_statement) { Statement.new }
  let(:deposit_one) { 10 }
  let(:withdraw_one) { 5 }
  let(:test_date) { Date.new(2012, 01, 10) }

  context 'when a new statement is created' do
    it 'has a history' do
      expect(test_statement.account_history).to eq []
    end
  end

  describe '#save_deposit_history' do
    context 'when a deposit is made' do
      it 'saves the deposit information to the account_history' do
        test_statement.save_deposit_history(deposit_one, test_date)
        expect(test_statement.account_history).to eq [{ Date: '10-01-2012', Deposit: 10, Withdraw: nil }]
      end
    end
  end

  describe '#save_withdraw_history' do
    context 'when a withdrawal is made' do
      it 'saves the withdrawal information to the account_history' do
        test_statement.save_withdraw_history(withdraw_one, test_date)
        expect(test_statement.account_history).to eq [{ Date: '10-01-2012', Deposit: nil, Withdraw: 5 }]
      end
    end
  end

  describe '#retrieve_history' do
    context 'when a statement is requested' do
      it 'retrieves the account history' do
        test_statement.save_deposit_history(deposit_one, test_date)
        test_statement.save_withdraw_history(withdraw_one, test_date)
        expect(test_statement.retrieve_history).to eq [{ Date: '10-01-2012', Deposit: 10, Withdraw: nil }, { Date: '10-01-2012', Deposit: nil, Withdraw: 5 }]
      end
    end
  end
end
