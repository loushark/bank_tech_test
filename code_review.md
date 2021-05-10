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
