require 'bank_account'


describe 'feature' do


  context 'prints a statement when the user deposits 1000.00 then deposits 2000.00 and finally withdraws 500.00' do
    it do
      client1 = BankAccount.new("Client1")
      client1.deposit(1000.00)
      client1.deposit(2000.00)
      client1.withdraw(500.00)
#       expected_outcome1 = 'Date       || Deposit || Withdraw || Balance
# 06-05-2021 ||         || 500.00   || 2500.00
# 06-05-2021 || 2000.00 ||          || 3000.00
# 06-05-2021 || 1000.00 ||          || 1000.00'
#       expect(client1.statement.format_statement).to eq expected_outcome1
      expected_outcome = "Successfully printed statement"
      expect(client1.print_statement).to eq expected_outcome
    end
  end
end
