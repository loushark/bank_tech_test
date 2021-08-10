Feedback from Simo Tchokni

Hey Lou, thanks for submitting your bank tech test!  
This was a good attempt at the challenge. You’ve done some object-oriented design and you have good tests. You could refine your design even further.  

###Here is my more detailed feedback:  
#### Documentation  
- Nice README! It was good to see details of your design and process.  
#### Object-oriented design
- You’ve separated the concerns of keeping a transaction history and managing withdrawals/deposits, nice :)  
- You could separate concerns even further. What if a new requirement to be able to format the statement different ways? Right now, because Statement does both formatting and storage, you’d have to store the transaction history twice in order to be able to print it in different ways or add extra methods to Statement which will make its interface less simple and clean. The fact that the data you’re storing inside account_history is already formatted as text also makes it harder if you later wanted to use the same account history but display it differently (or if an additional requirement came that requires being able to do numeric calculations on transactions).  
- You shouldn’t need to store the balance separately in an instance variable. It duplicates state since you’re already storing balances in the account history. Duplicating state can easily lead to bugs creeping in where the different values go out of sync.
#### Testing  
- Nice  
- You’ve achieved good isolation in your unit tests usinng mocking  
- In the BankAccount tests, you stubbed Statement.new so that you could inject a double into your BankAccount class. Another approach and perhaps simpler would have been to use dependency injection so that you can write something like BankAccount.new('Client 1', mock_statement), thereby passing your double in directly without having to stub.  
- I would argue that you are testing state rather than behaviour in statement_spec.rb when you directly inspect the list of transactions inside @account_history. Since you have the format_statement method, you should use that to check that the account history is correctly updated, that would be testing the public behaviour of the class (“when a deposit/withdrawal is saved, it shows up in the printed statemennt”) rather than the private implementation details (how exactly you choose to keep track of transactions).  
- You should put the feature test from your README into an rspec file and add an expectation to it so that it can be run along with the unit tests. You’ll have to add an expectation that checks that the output statement matches the expected statement. It’s good to use the acceptance criteria as an example in the feature test to show that they are met.  
- You’ve got some very long lines in your tests, it would be worth splitting those up. This stackoverflow has some suggestions for splitting up long strings: https://stackoverflow.com/questions/10522414/breaking-up-long-strings-on-multiple-lines-in-ruby-without-stripping-newlines  
#### Acceptance criteria
- You perhaps made the task a bit harder than it needed to be by trying to nicely format the table. The alignment of the columns/rows should be exactly as shown in the acceptance criteria (even if it looks worse than yours!)  
Once you’ve revisited these points please resubmit this tech test. And let me know if you have any questions about any of the above :)  


---- 
Follow up feedback from Alice Lieutier

Hey!
3:21
Here's my review for your bank tech test. Let me know if there's anything that is unclear.
3:21
Feature test
It’s good that you added a feature test, and the scenario is good. However, right now your feature test is testing the return of your print_statement function, whereas you probably should be testing the output of it, like you do in the Statement tests. You may have to use a gem like Timecop to simulate the passage of time.
bank_account_spec.rb
For the deposit and withdrawal, you are not really testing the behaviour of these methods. What I mean here, is that you test their return, but they could return a confirmation without doing their job. This is why a mock is useful when unit testing method that act on instances of other classes.
Think about what the deposit method is meant to do from a point of view of outside the class (that means returns + calls made to other objects)
When you call it with a number it should:
* Call save_deposit_history with the correct amount and date on the statement
* Return ‘Deposit amount saved to statement’
Both of these should be tested. You can test the first one using an expectation on the mock, including arguments. See more here: [Matching arguments - Setting constraints - RSpec Mocks - RSpec - Relish](https://relishapp.com/rspec/rspec-mocks/v/3-2/docs/setting-constraints/matching-arguments)
Same for withdrawal.
In doing this, you’l probably have to use a gem like timecop to freeze time, as well as test in a few different scenarios.
Acceptance Criteria
Your code still does not exactly match the acceptance criteria, and some companies can be very attached to their acceptance criteria, even going to have automated tests for your code (although they'll usually say it explicitly) so deviating (even on details) is often not recommended.
This is the spec:
date || credit || debit || balance
06/05/2021 || || 500.00 || 2500.00
06/05/2021 || 2000.00 || || 3000.00
06/05/2021 || 1000.00 || || 1000.00
And this is what your code would do:
date || credit  || debit  || balance
06-05-2021 ||  || 500.00 || 2500.00
06-05-2021 || 2000.00 ||  || 3000.00
06-05-2021 || 1000.00 ||  || 1000.00
Notice the date format and the spacing. The simplest for this type of test is actually to just copy paste the acceptance criteria directly in your tests, probably starting with a feature test.
statement.rb
Great to see the storage of the history separate from formatting. This is way more robust, as you can easily change the formatting after the fact. However, you are still storing state as strings. Why not go a step further and just store then as date objects, so they can be formatted at print time like the numbers. This way, you could easily have your app evolve to print statement with different formats at the same time.
In the format statement, you can probably extract some logic to make it easier to read. For example, you could extract a formatting_amount(amount) method whose job it it to return and empty string if the amount is nil, and a number formatted to two decimal otherwise.
* You could go further with the redesign of this class by not storing the balance twice. Duplication of information is never desirable. Instead of having @balance, it could be a method that finds the last balance. Something like:
def save_deposit_history(amount, date)
    balance = last_balance + amount
    @account_history << { Date: date.strftime('%d-%m-%Y'), Deposit: amount, Withdraw: nil, Balance: balance }
end

private

def last_balance
    @account_history.last[:Balance]
end
To push even further, you could just never store the balance (not even in the history), and just calculate it on the fly when you print the statement. If you go that way, you can simplify the history further by just having each “transaction” as just a date and amount. Then, at print time, if the amount is positive you put it in credit column, else in debit column.
bank_account.rb
Your deposit and withdraw method are just calling private methods. I’m not sure why that is - why not just write the code inside the public methods? Extracting code is useful if:
* the code is used in a number of places (DRY)
* you have a long a complex piece of code, and you want to cut it into several parts that are easier to understand.
Here, I don’t see a good reason for it. It just creates more code. (edited) 
relishapp.comrelishapp.com
Matching arguments - Setting constraints - RSpec Mocks - RSpec - Relish
Relish helps your team get the most from Behaviour Driven Development. Publish, browse, search, and organize your Cucumber features on the web.

