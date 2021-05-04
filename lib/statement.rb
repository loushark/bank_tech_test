# frozen_string_literal: true

#:nodoc:
class Statement
  attr_reader :account_history

  def initialize
    @account_history = []
  end

  def save_deposit_history(amount)
    @account_history << { Deposit: amount, Withdraw: nil }
  end

  def save_withdraw_history(amount)
    @account_history << { Deposit: nil, Withdraw: amount }
  end

  def retrieve_history
    @account_history
  end
end
