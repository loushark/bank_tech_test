# frozen_string_literal: true

#:nodoc:
class Statement
  attr_reader :account_history

  def initialize
    # @account_history = [{ Date: '10-01-2012', Deposit: 1000, Withdraw: " ", Balance: 1000 },
    #        { Date: '13-01-2012', Deposit: 2000, Withdraw: " ", Balance: 3000 },
    #        { Date: '14-01-2012', Deposit: " ", Withdraw: 500, Balance: 2500 }]
    @account_history = []
  end

  def save_deposit_history(amount, date, balance)
    @account_history << { Date: date.strftime('%d-%m-%Y'), Deposit: amount, Withdraw: " ", Balance: balance }
  end

  def save_withdraw_history(amount, date, balance)
    @account_history << { Date: date.strftime('%d-%m-%Y'), Deposit: " ", Withdraw: amount, Balance: balance }
  end

  def retrieve_history
    format_statement
    "End of statement"
  end

  def write_statement_lines(columns)
    @account_history.reverse.each do |h|
      info = h.keys.map { |k| h[k].to_s.ljust(columns[k][:width]) }.join(" || ")
      puts "#{info}"
    end
  end

  def format_statement
    col_labels = { Date: "Date", Deposit: "Deposit", Withdraw: "Withdraw", Balance: "Balance" }

    @columns = col_labels.each_with_object({}) { |(col,label),h|
      h[col] = { label: label,
                  width: [@account_history.map { |g| g[col].size }.max, label.size].max } }
     puts "#{ @columns.map { |_,g| g[:label].ljust(g[:width]) }.join(' || ') }"
    write_statement_lines(@columns)
  end
end
