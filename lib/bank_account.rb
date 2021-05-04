# frozen_string_literal: true

require_relative 'statement'
require 'date'

#:nodoc:
class BankAccount
  attr_reader :name, :balance

  def initialize(name)
    @name = name
    @balance = 0
    @statement = Statement.new
  end

  def deposit(amount)
    @balance += amount
    save_deposit_to_statement(amount)
  end

  def withdraw(amount)
    @balance -= amount
    save_withdraw_to_statement(amount)
  end

  def save_deposit_to_statement(amount)
    @statement.save_deposit_history(amount, Date.today)
    "Deposit amount saved to statement"
  end

  def save_withdraw_to_statement(amount)
    @statement.save_withdraw_history(amount, Date.today)
    "Withdrawal amount saved to statement"
  end



  def print_statement
    @statement.account_history
  end
end
