# frozen_string_literal: true

require_relative 'statement'

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
  end

  def withdraw(amount)
    @balance -= amount
  end

  def print_statement
    @statement.account_history
  end
end
