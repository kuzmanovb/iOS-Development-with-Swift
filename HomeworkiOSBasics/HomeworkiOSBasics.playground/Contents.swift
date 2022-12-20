import UIKit

enum Currency: String {
    case BGN = "BGN"
    case EUR = "EUR"
    case USD = "USD"
}

class Atm {
    
    var id : String = String(Int.random(in: 0...100))
    var currencyAvailability: [Currency: Double]
    var currencyConversionTax: Double
        
    init(currencyAvailability: [Currency: Double], currencyConversionTax: Double ) {
        self.currencyAvailability = currencyAvailability
        self.currencyConversionTax = currencyConversionTax
    }
    
    func withdrawingMoney (card: Card, desiredCurrency: Currency, sum: Double){
        
        if(desiredCurrency == Currency.BGN){
                    
            // if not had enough BGN in ATM, return
            if(self.currencyAvailability[.BGN] ?? 0.00 < sum){
                return print("Insufficient availability at ATM")
            }
                        
            // loop all currency
            var isMoneyTaken = false
            let currencies = [Currency.BGN, Currency.EUR, Currency.USD]
            for currentCurrency in currencies{
                
                if(isMoneyTaken){
                    break
                }
                
                // get current currency from user card
                var currencyAmountAtCard = card.bankAccount.currencyAvailability[currentCurrency] ?? 0.00
                // get current currency from atm
                var currencyBgnAmountAtAtm = self.currencyAvailability[.BGN] ?? 0.00
                  
                // convert current currency to BGN
                var currencyCardAmountToBgn : Double
                switch currentCurrency{
                case .BGN : currencyCardAmountToBgn = currencyAmountAtCard
                case .EUR : currencyCardAmountToBgn = currencyAmountAtCard * 1.956
                case .USD : currencyCardAmountToBgn = currencyAmountAtCard * 1.858
                }
                
                // calculate conversion tax
                var conversionTax = 0.00
                if(currentCurrency != Currency.BGN){
                    conversionTax = sum * (self.currencyConversionTax / 100)
                }
                
                // if has enough money, implementation process for take money
                if (currencyCardAmountToBgn + conversionTax >= sum){
                    
                    // convert money to current currency
                    var takenMoney = 0.00
                    switch currentCurrency{
                    case .BGN : takenMoney = sum
                    case .EUR : takenMoney = sum / 1.956 + conversionTax
                    case .USD : takenMoney = sum / 1.858 + conversionTax
                    }
          
                    // reduction money in card
                    card.bankAccount.currencyAvailability[currentCurrency] = currencyAmountAtCard - ((takenMoney * 100).rounded()/100)
                    // reduction money in ATM
                    self.currencyAvailability[.BGN]  = currencyBgnAmountAtAtm - sum
                    print("Given \(sum) BGN from \(currentCurrency) in card, remaining balance on the card \(card.bankAccount.currencyAvailability[currentCurrency] ?? 0.00) \(currentCurrency)")
                    isMoneyTaken = true
                    break
                }
            }
            if(!isMoneyTaken){
                return print("Insufficient funds on your account")
            }
            
            
        } else if(desiredCurrency == Currency.EUR){
            
            var moneyInEuroAtAtm = self.currencyAvailability[.EUR] ?? 0.00
            var moneyInEuroAtCard = card.bankAccount.currencyAvailability[.EUR] ?? 0.00
            
            if(sum > moneyInEuroAtCard){
                return print("Insufficient funds on your account")
            } else if (sum > moneyInEuroAtAtm){
                return print("Insufficient availability at ATM")
            } else {
               self.currencyAvailability[.EUR] = moneyInEuroAtAtm - sum
                card.bankAccount.currencyAvailability[.EUR] = moneyInEuroAtCard - sum
                print("You have successfully withdrawn \(sum) EUR, remaining balance on the card \(card.bankAccount.currencyAvailability[Currency.EUR] ?? 0.00) EUR")
            }
            
        } else{
            
            var moneyInEuroAtAtm = self.currencyAvailability[.USD] ?? 0.00
            var moneyInEuroAtCard = card.bankAccount.currencyAvailability[.USD] ?? 0.00
            
            if(sum > moneyInEuroAtCard){
                return print("Insufficient funds on your account")
            } else if (sum > moneyInEuroAtAtm){
                return print("Insufficient availability at ATM")
            } else {
               self.currencyAvailability[.USD] = moneyInEuroAtAtm - sum
                card.bankAccount.currencyAvailability[.USD] = moneyInEuroAtCard - sum
                print("You have successfully withdrawn \(sum) USD, remaining balance on the card \(card.bankAccount.currencyAvailability[.USD] ?? 0.00) USD")
            }
            
        }
    }
    
    func printBalance(){
        print("-----------------------------------------------------------------------------------------------------")
        print ("Balance on ATM")
       
        for currency in self.currencyAvailability{
            print ("Amount available \(currency.value) in \(currency.key) currency")
            
        }
    }
}

class BankAccount{
    
    var owner: String
    var iban: String
    var currencyAvailability: [Currency: Double]
    
    init(owner: String, iban: String, currencyAvailability: [Currency: Double]) {
        self.owner = owner
        self.iban = iban
        self.currencyAvailability = currencyAvailability
    }
    
}

class Card{
    
    var id: String = String(Int.random(in: 0...100))
    var owner: String
    var bankAccount: BankAccount
    
    init(owner: String, bankAccount: BankAccount) {
        self.owner = owner
        self.bankAccount = bankAccount
    }
    
    func printBalance(){
        print("-----------------------------------------------------------------------------------------------------")
        print("Balance on card of \(self.owner), bank account owner \(self.bankAccount.owner) with IBAN \(self.bankAccount.iban)")
        for currency in self.bankAccount.currencyAvailability{
            print ("Amount available \(currency.value) in \(currency.key) currency")
            
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var atmCurrencyAvailability = [Currency.BGN: 1200.00, Currency.EUR: 360.00, Currency.USD: 180.00 ]
var atm = Atm(currencyAvailability: atmCurrencyAvailability, currencyConversionTax: 2.00)


var cardCurrencyAvailability = [Currency.BGN: 460.00, Currency.EUR: 120.00, Currency.USD: 70.00 ]
var bankAccountOnIvan = BankAccount(owner: "Ivan Ivanov", iban: "NeSeZnae", currencyAvailability: cardCurrencyAvailability)


var cardOnIvan = Card(owner: "Ivan Ivanov", bankAccount: bankAccountOnIvan)
var cardOnIvanWife = Card(owner: "Maria Ivanova", bankAccount: bankAccountOnIvan)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// withdraw money from card of Ivan
print ("Result: ")
atm.withdrawingMoney(card: cardOnIvan, desiredCurrency: Currency.BGN, sum: 450.00)
atm.printBalance()
cardOnIvan.printBalance()

print("\n/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////\n")

/// withdraw money from card of Ivan's wife
print ("Result: ")
atm.withdrawingMoney(card: cardOnIvanWife, desiredCurrency: Currency.BGN, sum: 200.00)
atm.printBalance()
cardOnIvanWife.printBalance()

print("\n/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////\n")

/// withdraw money from card of Ivan's wife
print ("Result: ")
atm.withdrawingMoney(card: cardOnIvanWife, desiredCurrency: Currency.BGN, sum: 200.00)
atm.printBalance()
cardOnIvanWife.printBalance()

print("\n/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////\n")

print ("Result: ")
atm.withdrawingMoney(card: cardOnIvan, desiredCurrency: Currency.BGN, sum: 100.00)
atm.printBalance()
cardOnIvan.printBalance()

print("\n/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////\n")

print ("Result: ")
atm.withdrawingMoney(card: cardOnIvan, desiredCurrency: Currency.USD, sum: 100.00)
atm.printBalance()
cardOnIvan.printBalance()

print("\n/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////\n")

print ("Result: ")
atm.withdrawingMoney(card: cardOnIvan, desiredCurrency: Currency.USD, sum: 10.00)
atm.printBalance()
cardOnIvan.printBalance()
