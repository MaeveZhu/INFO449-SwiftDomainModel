# Greetings!
This exercise is designed to test your ability to work with complex composite types (classes and structs) in the Swift programming language.

Ted wrote this.

Your task is simple: Make the code compile, and make all the unit tests pass. You may not change the tests that already exist; you may, however, add a few tests, as well.

## To get started...
... you must first obtain a copy of the source. You do that by cloning this repository. Two options are available to you:

1. **Fork this repository.** From the GitHub repository web page, click "Fork" in the upper-right. This will create a copy of this repository in your own GitHub account. From there do a `git clone` from your own copy of the GitHub repository. (If you are unsure of the clone syntax, open the new repository in your account from the web, and click the green "Code" button--it will offer the correct syntax to use.)

2. **Clone and re-home this repository.** Open a "Command Prompt" or "Terminal" instance and use:

        git clone https://github.com/tedneward/INFO449-SwiftDomainModel

    ... to do the deed. This will also create a local copy of the project on your machine in a directory called `INFO449-SwiftDomainModel`. You will also need to "re-home" your local copy so it points to your own GitHub account; you can do this by creating a repository of this same name (`INFO449-SwiftDomainModel`) in your GitHub account and then executing `git remote set-url origin https://github.com/[your-ID]/INFO449-SwiftDomainModel.git`. (Needless to say, it's a lot easier to fork the repo.)

    In order to store your changes to your own GitHub account, you need to create a new repository on GitHub (call it `INFO449-SwiftDomainModel`), and then change the project's settings to point to that new repository as the remote origin.

        git remote set-url origin https://github.com/[your-ID]/INFO449-SwiftDomainModel.git

    Note, this will appear to succeed whether you got the syntax of the URL correct or not, so do a quick push to make sure it all worked correctly:

        git push

    Git will ask you for your username and password, then (if everything was done correctly), it will upload the code to the new repository, and this is your new "home" for this project going forward. Verify the files are there by viewing your GitHub project through the browser.
    
Now, you can begin to work on the homework code.

## To build the code; to run the tests
Swift from the command-line allows us to build and run the code without having to fire up XCode; it is useful to know how to do this, for this assignment, make sure your tests run from the command-line.

To run the complete set of tests, make sure your Terminal instance is in the same directory as the `Package.swift` file (the parent directory to `Sources` and `Tests`), and run `swift test`. It will compile the code, then run the tests, and then display what happens with all of the tests.

As you work, you will probably want to test your code in parts (Doing the Money class and tests first, before the others, for example). To run the tests for just one test add `--filter` and the name of the test suite you want to run, such as `swift test --filter JobTests` to run just the tests in JobTests. If you want to run just one test inside of a test suite, add a `/` and the name of the method you want to run, such as `swift test --filter JobTests/testCreateSalaryJob`.

When running tests, you will see output like

    /Users/tedneward/Projects/uw-swift-domain-model/Tests/DomainModelTests/JobTests.swift:8: error: -[DomainModelTests.JobTests testCreateSalaryJob] : XCTAssertTrue failed
    /Users/tedneward/Projects/uw-swift-domain-model/Tests/DomainModelTests/JobTests.swift:9: error: -[DomainModelTests.JobTests testCreateSalaryJob] : XCTAssertTrue failed
    Test Case '-[DomainModelTests.JobTests testCreateSalaryJob]' failed (0.057 seconds).
    Test Suite 'JobTests' failed at 2021-03-19 02:30:15.910.
      Executed 1 test, with 2 failures (0 unexpected) in 0.057 (0.058) seconds
    Test Suite 'DomainModelPackageTests.xctest' failed at 2021-03-19 02:30:15.910.
      Executed 1 test, with 2 failures (0 unexpected) in 0.057 (0.058) seconds
    Test Suite 'Selected tests' failed at 2021-03-19 02:30:15.911.
      Executed 1 test, with 2 failures (0 unexpected) in 0.057 (0.058) seconds

This is telling you that the `testCreateSalaryJob` test failed in two places: the "assert true" on line 8 of the JobTests.swift file failed, as did line 9. You will see output similar to this for each failed test; this is why it may be easier to test in pieces rather than the whole collection all the time.

## Your tasks
Your task is to create some types that will allow the associated unit tests to pass. Again, as with the other assignments you have done, you are free to examine the unit test code, but you may not modify it. Again, you are free to comment out parts of the unit tests to let your work compile as you go, but make sure no comments are present in the finished product that you turn in. 

Your domain model is going to represent a rather simple domain: real life. At least, the money, jobs, people and family parts of real life. (OK, so not really life, but a vast oversimplification of it. Such is what we do in programming.)

***NOTE:*** Where the tests might disagree with the spec written below, the tests win! (In other words, your goal is to make the tests pass, regardless of what the spec says.)

***NOTE:*** After cloning the project, you should be able to run the tests; note that some of the tests might pass, despite the implementation being missing! In most cases, this is due to bad tests. For an extra credit point, email myself and the TA with your suggestions on how the tests might be improved to prevent false positives like these from coming through.

### Money
To start, you will need to create a Money type (a struct). It will need two properties, `amount` and `currency`, since money is different in different cultures. (We will be ignoring fractional amounts like pennies for simplicity's sake; round up or down to the appropriate whole number when working with a fractional amount.) The `amount` should be an Int and the `currency` should be a String--make sure to include code to reject unknown currencies. Acceptable currencies are "USD", "GBP" (British pounds), "EUR" (Euro) and "CAN" (Canadian dollars, also known in the US as "funny money").

Money should also have three methods, `convert`, which takes a currency name as a parameter and returns a new Money that contains the converted amount, and `add` and `subtract`, which each take a Money as a parameter and returns a new Money that contains the addition or subtraction of the two. Note that it is entirely acceptable to add mixed-currency amounts (5 EUR to 7 USD, and so on).

Exchange rates are as follows:

* 1 USD = .5 GBP / 2 USD = 1 GBP

* 1 USD = 1.5 EUR / 2 USD = 3 EUR

* 1 USD = 1.25 CAN / 4 USD = 5 CAN

You will need to work out the rest of the math on your own. (Or, pro tip, "normalize" all currency conversions on USD--in other words, when converting from EUR to CAN, convert the EUR to USD and from there to CAN. It's less efficient, but it's also less complicated. You will not be graded by efficiency, only whether the tests pass.)

All of the Money tests are in MoneyTests.swift, if you want to see what's tested.

### Job
How do we get money? From jobs, of course! Create a class, called Job, that has two properties: `title`, a String describing the name of the job, and `type`, which will be an enumeration called JobType (which is already provided for you). Note that the JobType is a "discriminated union", meaning it is an enumeration that can carry data--in this case, the amount of either the Hourly wage (a Double) or the yearly Salary amount (an Int).

The two methods you must provide are:

* `calculateIncome`, which returns the amount of money (as an Integer, we're not worried about Money here) that this position makes in a calendar year. For Salary positions, this is simply the yearly amount; for Hourly positions, this is the hourly amount multiplied by 2000. (Interesting and important note for job seekers: assuming you get two weeks' off during the year, there are 50 weeks * 40 hours/week, or 2000 working hours in a given calendar year.)

* `raise`, which should bump the amount of the Salary or the Hourly by the given amount, and/or by the given percentage. (In other words, `raise` should be overloaded by parameter name.)

All of the Job tests are in JobTests.swift, if you want to see what's tested.

### Person
Now we want to start modeling those carbon-based life forms that do jobs, a la people. Create a class, called Person, which will have the following five properties:

* `firstName` and `lastName`, both Strings

* `age`, an Int

* `job`, a Job (the rough syntax for the property is provided for you)

* `spouse`, a Person (the rough syntax for the property is provided for you)

Note that `job` and `spouse` are nullable, whereas the others aren't.

Create an initializer to take the first three as parameters; since `job` and `spouse` are not always present (not everyone has a job, and certainly not everyone is married), leave those out of the initializer.

Create a method to display a human-readable String of the contents of a Person. (Since so many of you--and me--are all comfortable with Java, call it `toString`.) Put some reasonable display of the Person class there, along the lines of `[Person: firstName: Ted lastName: Neward age: 45 job: Salary(1000) spouse: Charlotte]`.

All of the Person tests are in PersonTests.swift, if you want to see what's tested.

### Family
Finally, a family is a group of people, some of whom have jobs, some don't, but whose total income is what's taxed come April 1. Create a class called Family that has one property, `members`, which is a collection of Persons. US law dictates that a family consists of two Persons at a minimum (spouse1 and spouse2), so create an initializer that takes two Person parameters (called `spouse1` and `spouse2` to avoid genderfying parameter names). However, US law also frowns on being married more than once at the same time, so make sure your two parameters each have no spouse, and set their respective `spouse` fields to each other.

Next, flesh out the `haveChild` method, which takes a Person parameter to add to the family. However, US law also frowns on minors having children, so let's make sure that at least one Person of the two spouses is over the age of 21. If the Family cannot have a child, then this method should return `false`; this method should return `true` only if the child can be successfully added to the Family.

Finally, the `householdIncome` method will calculate the complete income for the Family.

All of the Family tests are in PersonTests.swift, if you want to see what's tested.

### Tag the DomainModel
When you have completed the exercise, tag your package in GitHub as `1.0.0` (exactly) so that it can be referenced from GitHub for the next assignment. Remember to push your tag to the remote server (GitHub); verify that the tag is there by looking at your repo in GitHub over the web.

## Extra Credit tasks
There are a few things you can do to earn some extra points for this assignment. If you do any of these, let the TA know so we can make sure to take a look--we won't know, otherwise. In no particular order:

* **Write some additional tests (1-3 points).** Double up the number of tests currently in the domain model. For each additional eight tests you write, you earn one additional credit point, up to 3 more points. Write tests that attempt to "break" the classes--what happens if you pass in negative values for `Money`, can you pass in illegal currency types for `Money`, can you pass in negative values for `Job`'s `JobType`, and so on. Note that part of writing tests is to make sure that once you've gotten the test to break the class, you have to go back and fix the class so the tests don't break!
* **Write code to "convert" Jobs (1 point).** Sometimes an hourly employee's position converts to full-time; in those situations, their Job must convert from an Hourly to Salary. Write a method `convert` to convert the `Job` into one that has a Salary equivalent to the Hourly rate multiplied by 2000, rounded up to the nearest 1000. (Note that the `Job` should always stay in the same currency it was created in, regardless of Hourly or Salary.) Then, write some tests to exercise this conversion.
    > ***DESIGN NOTE:*** In other books or literature, you may see a similar kind of example like this where `Job` is a base class, and `HourlyJob` and `SalaryJob` are subclasses of `Job`. There is value in that, but it means that you cannot do this kind of in-place conversion from one kind of job to another. That can be limiting--and tells you of some of the limitations of inheritance.
* **Modify Person to accept Beyonce and Bono (1 point).** Some people are famous enough that they are known entirely by just one name. Our system currently requires every `Person` to have both a first and a last name. Modify `Person` to accept either just a first name, or a last name, or both, and write additional tests to make sure `Person` still works the way it's supposed to (*i.e.*, don't break or modify any of the other tests).
    > ***DESIGN NOTE:*** Names are actually ridiculously hard to model correctly. Once you get past the single-word-only names (including Sonny and Cher from your grandparents' generation, and Prince from mine), you also run into people who have multiple middle names (George Herbert Walker Bush), and the fact that in several cultures, the "family name" formally comes in front of the "surname", so that I would be known in those cultures as Neward Ted.

## Make sure it all is pushed to GitHub! Remember, if it's not in GitHub, it doesn't exist!
Create a new directory on your laptop, `git clone` your repo, and try to run the tests (which will try to build the code as well). This is exactly what the TA will be doing, so if it doesn't run, you need to correct something!
