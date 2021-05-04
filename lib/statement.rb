class Statement
attr_reader :account_history

  def initialize
    @account_history = []
  end

  def save_deposit_history(amount)
    @account_history << { Deposit: amount }
  end
end
