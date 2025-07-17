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
  
  func open(_ shouldOpen: Bool = Bool.random()) throws -> Bool {
    guard shouldOpen else {
      throw Bool.random() ? BakeryError.inventory : BakeryError.noPower
    }
    return shouldOpen
  }
    
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

do {
  try bakery.open()
  try bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
}
// Handle each BakeryError
catch let error as BakeryError {
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
// Handle unexpected errors
catch {
  print("Something went wrong: \(error)")
}

do {
  try bakery.open()
  try bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
}
// Another way to handle every error
catch BakeryError.inventory, BakeryError.noPower {
  print("Sorry, the bakery is now closed.")
} catch BakeryError.doNotSell {
  print("Sorry, but we don't sell this item.")
} catch BakeryError.wrongFlavor {
  print("Sorry, but we don't carry this flavor.")
} catch BakeryError.tooFew(numberOnHand: let items) {
  print("Sorry, we only have \(items) cookies left.")
} catch {
  print("Some other error.")
}

// If you don’t care about the error details, use try? to wrap the result of a function in an optional.
let open = try? bakery.open(false)
let remaining = try? bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")

// If you know for sure that your code is not going to fail, use try!
try! bakery.open(true)
try! bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")

// This has the same effect as:
do {
  try bakery.open(true)
  try bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
}
catch {
  fatalError()
}

//: [Next](@next)
