//: [Previous](@previous)

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
  
  var itemsForSale = [
    "Cookie": Pastry(flavor: "ChocolateChip", numberOnHand: 20),
    "PopTart": Pastry(flavor: "WildBerry", numberOnHand: 13),
    "Donut" : Pastry(flavor: "Sprinkles", numberOnHand: 24),
    "HandPie": Pastry(flavor: "Cherry", numberOnHand: 6)
  ]
  
  // Method throws only BakeryError
  func open(_ shouldOpen: Bool = Bool.random()) throws(BakeryError) -> Bool {
    guard shouldOpen else {
      throw Bool.random() ? BakeryError.inventory : BakeryError.noPower
    }
    return shouldOpen
  }
    
  // Method throws only BakeryError
  func orderPastry(item: String, amountRequested: Int, flavor: String) throws(BakeryError) -> Int {
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
  
// catch doesn't need to specify BakeryError
do {
  try bakery.open()
  try bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
}
// Handle each BakeryError
catch let error {
  switch error {
  case .inventory, .noPower:
    print("Sorry, the bakery is now closed.")
  case .doNotSell:
    print("Sorry, but we don't sell this item.")
  case .wrongFlavor:
    print("Sorry, but we don't carry this flavor.")
  case .tooFew(numberOnHand: let items):
    print("We only have \(items) cookies left.")
  }
}

do {
  try bakery.open()
  try bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
}
// Another way to handle every error
catch .inventory, .noPower {
  print("Sorry, the bakery is now closed.")
} catch .doNotSell {
  print("Sorry, but we don't sell this item.")
} catch .wrongFlavor {
  print("Sorry, but we don't carry this flavor.")
} catch .tooFew {
  print("Sorry, we don't have enough items to fulfill your order.")
// No other type of error is possible, so compiler warns "Case will never be executed"
//} catch {
//  print("Some other error.")
}

//: [Next](@next)
