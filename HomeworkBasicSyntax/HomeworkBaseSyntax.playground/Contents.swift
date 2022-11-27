import UIKit

//Task 1
//Write function for calculation of surface of triangle based on side and the height to this side. The
//inputed parameters must be from type Float. Provide example use of your function and print the
//result of the surface


func calculateTriangleSurface(side:Float, heigth: Float) -> Double {
    
    var surface: Double = 0.5 * Double(side) * Double(heigth)
    
    return surface
}

print(calculateTriangleSurface(side: 3.5, heigth: 4.2))

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Task 2
//Write function for calculation of surface and perimeter of a circle based on the radius. The inputed parameters must be from type Float.
//Provide example use of your function and print the result of the surface.

struct CircleData{
    var surface: Double
    var perimeter: Double
}

func calculationCircleSurfaceAndPerimeter(radius: Float) -> CircleData {
    
    var circleData = CircleData(
        surface: Double.pi * pow(Double(radius), 2),
        perimeter: 2 * Double(radius) * Double.pi)
    
    return circleData
}

print(calculationCircleSurfaceAndPerimeter(radius:23.5))

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Task 3
//Create a structure Car with parameters : Make(String), Model(String), Horse Power(Double), Torque(Float), Date Of Manufacturing (String).
//    1. Make a function that accepts Car as parameter and print all the information as coma separated value (CSV) String.
//    2. Make a function that accepts Car as parameter and prints the Power of the car in Watts (not in hps)

struct Car {
    var Make:String
    var Model: String
    var HorsePower: Double
    var Torque: Float
    var DateOfManufacturing: String
}

func printCarInformation(car : Car){
    
    print("Make: \(car.Make), Model: \(car.Model), Horse Power: \(car.HorsePower), Torque: \(car.Torque), Date Of Manufacturing: \(car.DateOfManufacturing)")
}

func printCarPowerInWatts(car: Car){
    
    // 1 horsepower [HP] =  745.699872 watt
    print ("Power In Watts Of Car Is: \(car.HorsePower *  745.699872)" )
}

var sameCar = Car(Make: "Toyota", Model: "Corolla", HorsePower: 132, Torque: 4, DateOfManufacturing: "09.2015")

printCarInformation(car: sameCar)

printCarPowerInWatts(car: sameCar)

