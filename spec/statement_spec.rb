# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:test_statement) { Statement.new }
  let(:deposit_one) { 10 }
  let(:withdraw_one) { 5 }
  let(:test_date) { Date.new(2012, 01, 10) }
  let(:test_balance) { 12 }
  let(:test_balance2) { 23 }

  context 'when a new statement is created' do
    it 'has a history' do
      expect(test_statement.account_history).to eq []
    end
  end

  describe '#save_deposit_history' do
    context 'when a deposit is made' do
      it 'saves the deposit information to the account_history' do
        test_statement.save_deposit_history(deposit_one, test_date, test_balance)
        expect(test_statement.account_history[0][:Deposit]).to eq 10
      end
    end
  end

  describe '#save_withdraw_history' do
    context 'when a withdrawal is made' do
      it 'saves the withdrawal information to the account_history' do
        test_statement.save_withdraw_history(withdraw_one, test_date, test_balance)
        expect(test_statement.account_history[0][:Withdraw]).to eq 5
      end
    end
  end


  describe '#retrieve_history' do
    context 'when a statement is requested' do
      it 'retrieves the account history' do
        test_statement.save_deposit_history(deposit_one, test_date, test_balance)
        test_statement.save_withdraw_history(withdraw_one, test_date, test_balance)
        expect(test_statement.retrieve_history).to eq [{ Date: '10-01-2012', Deposit: 10, Withdraw: nil, Balance: 12 }, { Date: '10-01-2012', Deposit: nil, Withdraw: 5, Balance: 12 }]
      end

      it 'includes a balance for each line on the statement' do
        test_statement.save_deposit_history(deposit_one, test_date, test_balance)
        test_statement.save_withdraw_history(withdraw_one, test_date, test_balance2)
        expect(test_statement.account_history[0][:Balance]).to eq 12
        expect(test_statement.retrieve_history[1][:Balance]).to eq 23
      end
    end
  end
end
