class BankAccount
  attr_reader :name, :balance

  def initialize(name)
    @name = name
    @balance = 0
  end
end
