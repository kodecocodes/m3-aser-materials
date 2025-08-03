/// Copyright (c) 2025 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

class Pastry {
  let flavor: String
  var numberOnHand: Int
    
  init(flavor: String, numberOnHand: Int) {
    self.flavor = flavor
    self.numberOnHand = numberOnHand
  }
}

enum BakeryError: Error {
  case tooFew(numberOnHand: Int), noSuchItem, wrongFlavor
  case noInventory, noPower
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
      throw Bool.random() ? .noInventory : .noPower
    }
    return shouldOpen
  }
    
  // Method throws only BakeryError
  func orderPastry(item: String, amountRequested: Int, flavor: String) throws(BakeryError) -> Int {
    guard let pastry = itemsForSale[item] else {
      throw .noSuchItem
    }
    guard flavor == pastry.flavor else {
      throw .wrongFlavor
    }
    guard amountRequested <= pastry.numberOnHand else {
      throw .tooFew(numberOnHand: pastry.numberOnHand)
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
catch let error {  // error is type BakeryError
  switch error {
  case .noInventory, .noPower:
    print("Sorry, the bakery is now closed.")
  case .noSuchItem:
    print("Sorry, but we don't sell this item.")
  case .wrongFlavor:
    print("Sorry, but we don't carry this flavor.")
  case .tooFew(numberOnHand: let items):
    print("We only have \(items) cookies left.")
  }
}
// No other type of error is possible, so compiler warns "Case will never be executed"
//catch {
//  print("Something went wrong: \(error)")
//}

do {
  try bakery.open()
  try bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
}
// Another way to handle every error
catch .noInventory, .noPower {
  print("Sorry, the bakery is now closed.")
} catch .noSuchItem {
  print("Sorry, but we don't sell this item.")
} catch .wrongFlavor {
  print("Sorry, but we don't carry this flavor.")
} catch .tooFew(numberOnHand: let items) {
  print("We only have \(items) cookies left.")
// No other type of error is possible, so compiler warns "Case will never be executed"
//} catch {
//  print("Some other error.")
}

//: [Next](@next)
