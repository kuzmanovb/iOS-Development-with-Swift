import UIKit

// Task 1
// Make a function for calculating average fuel consumption in liters per 100 km.

func calculateAverageFuelPer100Kilometers(traveledKilometers: Double, fuelSpent: Double) -> String {
    
    var result = fuelSpent / (traveledKilometers / 100.00)
    return String(format: "Average fuel spent: %.3f liters", result)
}

print(calculateAverageFuelPer100Kilometers(traveledKilometers: 200, fuelSpent: 24.2))

// Task 2
// Make a function that is used for adding distance, amount of fuel, and date of fueling (as string).
// Calculate the average fuel consumption between the current and the last fueling.

func calculateAverageConsumption(kilometers: Double, amountFuel: Double, dateOfFueling: String) -> String {
    
    var result =  amountFuel / (kilometers / 100.00)
    return String(format: "Average comsuption: %.3f liters", result)
}

print(calculateAverageConsumption(kilometers: 320, amountFuel: 28.2, dateOfFueling: "12/6/2022"))

// Task 3
// Make a function for converting l/100km to mpg.

func convertLitersToGallon(liters: Double) -> String {
    
    // 1 US gallon = 3.78541178 litres
    var result = liters / 3.78541178
    return String(format: "%.3f liters is %.3f gallons", liters, result)
}

print(convertLitersToGallon(liters: 34))

// Task 4
// Make a function for calculating the average price per kilometer on a given fuel price per liter.

func calculateAverachPrice(traveledKilometers: Double, fuelSpent: Double, fuelPricePerLiter: Double) -> String {
    
    var spentAmont = fuelSpent * fuelPricePerLiter
    var averagePricePerKilometer = traveledKilometers / spentAmont
    
    return String(format: "Traveling %.2F kilometers, average price for per kilometer is:  %.2f $", traveledKilometers, averagePricePerKilometer)
}

print(calculateAverachPrice(traveledKilometers: 100.00, fuelSpent: 8.5, fuelPricePerLiter: 2.55))

// Task 5
// Make a function to print information about fuel consumption and the date of fueling.
