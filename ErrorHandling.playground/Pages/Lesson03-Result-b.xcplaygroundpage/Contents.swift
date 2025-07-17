//: [Previous](@previous)

import Foundation

// Create a Result from a throwing expression
// init(catching: () throws(Failure) -> Success)

class Pastry {
  let flavor: String
  var numberOnHand: Int

  init(flavor: String, numberOnHand: Int) {
    self.flavor = flavor
    self.numberOnHand = numberOnHand
  }
}

enum BakeryError: Error {
  case tooFew(numberOnHand: Int), doNotSell, wrongFlavor
  case inventory, noPower
}

class Bakery {
  let itemsForSale = [
    "Cookie": Pastry(flavor: "ChocolateChip", numberOnHand: 20),
    "PopTart": Pastry(flavor: "WildBerry", numberOnHand: 0),  // guaranteed error
    "Donut" : Pastry(flavor: "Sprinkles", numberOnHand: 24),
    "HandPie": Pastry(flavor: "Cherry", numberOnHand: 6)
  ]

  func orderPastry(item: String, amountRequested: Int, flavor: String) throws -> Int {
    guard let pastry = itemsForSale[item] else {
      throw BakeryError.doNotSell
    }
    guard flavor == pastry.flavor else {
      throw BakeryError.wrongFlavor
    }
    guard amountRequested <= pastry.numberOnHand else {
      throw BakeryError.tooFew(numberOnHand: pastry.numberOnHand)
    }
    pastry.numberOnHand -= amountRequested

    return pastry.numberOnHand
  }
}

let bakery = Bakery()

var results = [Result<Int, Error>]()
for (key, value) in bakery.itemsForSale {
  // Invoke throwing expression in closure passed to init(catching:)
  let result = Result { try bakery.orderPastry(item: key, amountRequested: 1, flavor: value.flavor) }
  results.append(result)
}
results

//: [Next](@next)
