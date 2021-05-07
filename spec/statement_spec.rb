# frozen_string_literal: true

require 'statement'

describe Statement do
  let(:test_statement) { Statement.new }
  let(:test_date1) { Date.new(2012, 01, 10) }
  let(:test_date2) { Date.new(2012, 01, 13) }
  let(:test_date3) { Date.new(2012, 01, 14) }
  let(:test_deposit1) { 1000.00 }
  let(:test_deposit2) { 2000.00 }
  let(:test_withdraw1) { 500.00 }
  let(:test_balance1) { 1000.00 }
  let(:test_balance2) { 3000.00 }
  let(:test_balance3) { 2500.00 }

  describe '#format_statement' do
    context 'when a deposit is made' do
      it 'the statement has values for a date, credit and balance' do
        test_statement.save_deposit_history(test_deposit1, test_date1)
        expect { test_statement.format_statement }.to output(
        "date || credit  || debit  || balance\n"  \
        " 10-01-2012 || 1000.00 ||  || 1000.00\n").to_stdout
      end
    end

    context 'when a withdrawal is made' do
      it 'the statement has values for a date, debit and balance' do
        test_statement.save_withdraw_history(test_withdraw1, test_date2)
        expect { test_statement.format_statement }.to output(
        "date || credit  || debit  || balance\n"  \
        " 13-01-2012 ||  || 500.00 || -500.00\n").to_stdout
      end
    end

    context 'when a statement is requested' do
      it 'column headings for the statment are formatted' do
        expect { test_statement.statement_header }.to output(
        "date || credit  || debit  || balance\n").to_stdout
      end

      it 'prints a fully formatted statement in table form' do
        test_statement.save_deposit_history(test_deposit1, test_date1)
        test_statement.save_deposit_history(test_deposit2, test_date2)
        test_statement.save_withdraw_history(test_withdraw1, test_date3)
        expect { test_statement.format_statement }.to output(
        "date || credit  || debit  || balance\n" \
        " 14-01-2012 ||  || 500.00 || 2500.00\n" \
        " 13-01-2012 || 2000.00 ||  || 3000.00\n" \
        " 10-01-2012 || 1000.00 ||  || 1000.00\n"
        ).to_stdout
      end
    end
  end
end
