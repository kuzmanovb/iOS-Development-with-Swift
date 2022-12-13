import UIKit

struct CashDispenser {
    var id : String
    var currencyAvailability: [String: Double]
    var currencyConversionTax: Double
 }

struct Card{
    var id : String
    var owner : String
    var currencyAvailability: [String: Double]
}

var atm = CashDispenser(
    id: "1",
    currencyAvailability: ["BGN" : 132.20],
    currencyConversionTax : 0.02
)

var userCard = Card(
    id: "1",
    owner : "Ivan Ivanov",
    currencyAvailability : ["BGN" : 15.50, "EUR" : 20.10, "USD" : 30.20]
)

func getCashMoneyFromAtm(money : Double){
    
    // if ATM not enoungh money print message and return
    if(atm.currencyAvailability["BGN"] ?? 0 < money){
        print("Insufficient availability at the ATM")
        return
    }
    
    // loop all user currency
    var isMoneyTaken = false
    var currentUserCurrency = ["BGN", "EUR", "USD"]
    for currency in currentUserCurrency {
        if(isMoneyTaken){
            break
        }
        
        // get current currency from user card
        var currencyAmount = userCard.currencyAvailability[currency] ?? 0.00
        
        // convert current currency to BGN
        var currencyAmountToBgn = 0.00
        switch currency{
        case "BGN" : currencyAmountToBgn = currencyAmount
        case "EUR" : currencyAmountToBgn = currencyAmount * 1.956
        case "USD" : currencyAmountToBgn = currencyAmount * 1.858
        default: 0
        }
        
        // calculate conversion tax
        var conversionTax = 0.00
        if(currency != "BGN"){
            conversionTax = money * atm.currencyConversionTax
        }
        
        // if has enough money, implementation process for take money
        if (currencyAmountToBgn + conversionTax >= money){
            
            // convert money to current currency
            var takenMoney = 0.00
            switch currency{
            case "BGN" : takenMoney = money
            case "EUR" : takenMoney = money / 1.956 + conversionTax
            case "USD" : takenMoney = money / 1.858 + conversionTax
            default: 0
            }
            
            // reduction of money in ATM and user card
            userCard.currencyAvailability[currency] = currencyAmount - takenMoney
            var atmCurrency = atm.currencyAvailability["BGN"] ?? 0.00
            atm.currencyAvailability["BGN"] = atmCurrency - money
            print("Given \(money) BGN from \(currency) in card")
            isMoneyTaken = true
            break
        }
        
    }
    
    // if no enough money print message
    if(!isMoneyTaken){
        print ("Insufficient funds on your account")
    }
}


getCashMoneyFromAtm(money: 10.71)
getCashMoneyFromAtm(money: 10.71)
getCashMoneyFromAtm(money: 30.71)
getCashMoneyFromAtm(money: 1.21)
getCashMoneyFromAtm(money: 60.71)
