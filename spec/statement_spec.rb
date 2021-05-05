# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:test_statement) { Statement.new }
  let(:deposit_one) { 10 }
  let(:withdraw_one) { 5 }
  let(:test_date) { Date.new(2012, 01, 10) }
  let(:test_balance) { 12 }
  let(:test_balance2) { 23 }
  let(:test_columns) { {:Date=>{:label=>"Date", :width=>10}, :Deposit=>{:label=>"Deposit", :width=>8}, :Withdraw=>{:label=>"Withdraw", :width=>8}, :Balance=>{:label=>"Balance", :width=>8}} }

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
        expect(test_statement.retrieve_history).to eq "End of statement"
        # [{ Date: '10-01-2012', Deposit: 10, Withdraw: nil, Balance: 12 }, { Date: '10-01-2012', Deposit: nil, Withdraw: 5, Balance: 12 }]
      end

      it 'includes a balance for each line on the statement' do
        test_statement.save_deposit_history(deposit_one, test_date, test_balance)
        test_statement.save_withdraw_history(withdraw_one, test_date, test_balance2)
        expect(test_statement.account_history[0][:Balance]).to eq 12
        expect(test_statement.account_history[1][:Balance]).to eq 23
      end

      it 'prints a formatted statment in table form' do
        test_statement.save_deposit_history(1000, Date.new(2012, 01, 10), 1000)
        test_statement.save_deposit_history(2000, Date.new(2012, 01, 13), 3000)
        test_statement.save_withdraw_history(500, Date.new(2012, 01, 14), 2500)
        expect { test_statement.retrieve_history }.to output(
       "Date       || Deposit  || Withdraw || Balance \n14-01-2012 ||          || 500      || 2500    \n13-01-2012 || 2000     ||          || 3000    \n10-01-2012 || 1000     ||          || 1000    \n").to_stdout
      end
    end
  end

  describe '#format_statement' do
    context 'when the account history is retrieved' do
      it 'columns for a table are formatted' do
        test_statement.save_deposit_history(1000, Date.new(2012, 01, 10), 1000)
        expect { test_statement.format_statement }.to output(
       "Date       || Deposit  || Withdraw || Balance \n10-01-2012 || 1000     ||          || 1000    \n").to_stdout
      end
    end
  end

  describe '#write_statement_lines' do
    context 'when the account history is retrieved' do
      it 'formats the account history into a readable table format' do
        test_statement.save_deposit_history(1000, Date.new(2012, 01, 10), 1000)
        test_statement.save_deposit_history(2000, Date.new(2012, 01, 13), 3000)
        test_statement.save_withdraw_history(500, Date.new(2012, 01, 14), 2500)
        p "hello:"
        # p test_statement.write_statement_lines
        expect { test_statement.write_statement_lines(test_columns) }.to output(
       "14-01-2012 ||          || 500      || 2500    \n13-01-2012 || 2000     ||          || 3000    \n10-01-2012 || 1000     ||          || 1000    \n").to_stdout
      end
    end
  end
end
