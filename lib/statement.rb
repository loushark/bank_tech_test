# frozen_string_literal: true

#:nodoc:
class Statement
  attr_reader :account_history

  def initialize
    @account_history = []
  end

  def save_deposit_history(amount, date, balance)
    @account_history << { Date: date.strftime('%d-%m-%Y'), Deposit: (format '%.2f', amount), Withdraw: ' ',
                          Balance: (format '%.2f', balance) }
  end

  def save_withdraw_history(amount, date, balance)
    @account_history << { Date: date.strftime('%d-%m-%Y'), Deposit: ' ', Withdraw: (format '%.2f', amount),
                          Balance: (format '%.2f', balance) }
  end

  def write_statement_lines(columns)
    @account_history.reverse.each do |h|
      info = h.keys.map { |k| h[k].to_s.ljust(columns[k][:width]) }.join(' || ')
      puts info.to_s
    end
  end

  def format_statement
    col_labels = { Date: 'Date', Deposit: 'Deposit', Withdraw: 'Withdraw', Balance: 'Balance' }

    @columns = col_labels.each_with_object({}) do |(col, label), h|
      h[col] = { label: label,
                 width: [@account_history.map { |g| g[col].size }.max, label.size].max }
    end
    puts @columns.map { |_, g| g[:label].ljust(g[:width]) }.join(' || ').to_s
    write_statement_lines(@columns)
  end
end
