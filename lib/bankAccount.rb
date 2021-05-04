class BankAccount
  attr_reader :name, :balance

  def initialize(name)
    @name = name
    @balance = 0
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end
