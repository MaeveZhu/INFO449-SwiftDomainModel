struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    /*amount and currency*/
    var amount: Int = 0
    var currency: String = ""
    let acceptableCurrencies: Set<String> = ["USD", "EUR", "GBP", "CAN"]
    
    // assign currency to convert between USD
    private let toUSDRates: [String: Double] = [
        "USD": 1.0,
        "GBP": 2.0,
        "EUR": 0.667,
        "CAN": 0.8
    ]
    
    private let fromUSDRates: [String: Double] = [
        "USD": 1.0,
        "GBP": 0.5,
        "EUR": 1.5,
        "CAN": 1.25
    ]
    
    // convert
    // [Source Currency: Amount] → [USD: Intermediate Amount] → [Target Currency: Final Amount]
    func convert(_ finalCurrency: String) -> Money {
        let input2usd = toUSDRates[self.currency]!
        let usdAmount = Double(self.amount) * input2usd

        let usd2Output = fromUSDRates[finalCurrency]!
        let finalAmount = Int((usdAmount * usd2Output).rounded())

        return Money(amount: finalAmount, currency: finalCurrency)
    }
    
    func add(_ right: Money) -> Money {
        let left = self.convert(right.currency)
        let totalAmount = left.amount + right.amount
        return Money(amount: totalAmount, currency: right.currency)
    }
    
    func extract(_ right: Money) -> Money {
        let left = self.convert(right.currency)
        let totalAmount = left.amount - right.amount
        return Money(amount: totalAmount, currency: right.currency)
    }
}

////////////////////////////////////
// Job
public class Job {
    var title: String = ""
    var type: JobType

    public enum JobType {
        case Hourly(Double)  // hourly rate
        case Salary(UInt)    // annual salary
    }

    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }


    func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Hourly(let rate):
            return Int(rate * Double(hours))
        case .Salary(let salary):
            return Int(salary)
        }
    }
    
    func raise(byAmount amount: Double) {
        switch type {
        case .Hourly(let rate):
            type = .Hourly(rate + amount)
        case .Salary(let salary):
            type = .Salary(salary + UInt(amount))
        }
    }
    
    func raise(byPercent percent: Double) {
        switch type {
        case .Hourly(let rate):
            let newRate = rate * (1 + percent)
            type = .Hourly(newRate)
        case .Salary(let salary):
            let newSalary = Double(salary) * (1 + percent)
            type = .Salary(UInt((newSalary)))
        }
    }

}


////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int

    private var _job: Job? = nil
    var job: Job? {
        get { return _job }
        set {
            if age >= 16 {
                _job = newValue
            }
        }
    }

    private var _spouse: Person? = nil
    var spouse: Person? {
        get { return _spouse }
        set {
            if age >= 18 {
                _spouse = newValue
            }
        }
    }

    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    func toString() -> String {
        let jobString: String
        if let job = self.job {
            switch job.type {
            case .Hourly(let rate): jobString = "Hourly(\(rate))"
            case .Salary(let amount): jobString = "Salary(\(amount))"
            }
        } else {
            jobString = "nil"
        }

        let spouseName = self.spouse?.firstName ?? "nil"

        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(jobString) spouse:\(spouseName)]"
    }
}


////////////////////////////////////
// Family
//
public class Family {
    var members: [Person] = []

    init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }

        members.append(spouse1)
        members.append(spouse2)
    }

    func haveChild(_ child: Person) -> Bool {
        if members.count >= 2 {
            let parent1 = members[0]
            let parent2 = members[1]
            if parent1.age >= 21 || parent2.age >= 21 {
                members.append(child)
                return true
            }
        }
        return false
    }

    func householdIncome() -> Int {
        var total = 0
        for member in members {
            if let job = member.job {
                switch job.type {
                case .Hourly(let rate):
                    total += Int(rate * 2000)
                case .Salary(let salary):
                    total += Int(salary)
                }
            }
        }
        return total
    }
}

