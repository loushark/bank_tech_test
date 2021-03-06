# frozen_string_literal: true

#:nodoc:
class Statement
  # attr_reader :account_history

  def initialize
    @balance = 0
    @account_history = []
  end

  def save_deposit_history(amount, date)
    update_balance(amount)
    @account_history << { Date: date.strftime('%d-%m-%Y'), Deposit: amount, Withdraw: nil, Balance: @balance }
  end

  def save_withdraw_history(amount, date)
    update_balance(amount * -1)
    @account_history << { Date: date.strftime('%d-%m-%Y'), Deposit: nil, Withdraw: amount, Balance: @balance}

  end

  def statement_header
    puts "date || credit  || debit  || balance"
  end

  def format_statement
    statement_header

    @account_history.reverse.each do |line|
      puts " #{line[:Date]} || " \
      "#{line[:Deposit] == nil ? line[:Deposit] : (format '%.2f', line[:Deposit])} " \
      "|| #{line[:Withdraw] == nil ? line[:Withdraw] : (format '%.2f', line[:Withdraw])} " \
      "|| #{(format '%.2f', line[:Balance])}"
    end
  end

  private

  def update_balance(amount)
    @balance += amount
  end
end
