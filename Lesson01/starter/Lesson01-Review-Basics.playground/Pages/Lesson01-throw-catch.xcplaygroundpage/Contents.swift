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

//: [Previous](@previous)

class Pastry {
  let flavor: String
  var numberOnHand: Int
    
  init(flavor: String, numberOnHand: Int) {
    self.flavor = flavor
    self.numberOnHand = numberOnHand
  }
}

// TODO: Define BakeryError: Error enum

class Bakery {
  var itemsForSale = [
    "Cookie": Pastry(flavor: "ChocolateChip", numberOnHand: 20),
    "PopTart": Pastry(flavor: "WildBerry", numberOnHand: 13),
    "Donut" : Pastry(flavor: "Sprinkles", numberOnHand: 24),
    "HandPie": Pastry(flavor: "Cherry", numberOnHand: 6)
  ]
  
  func open(_ shouldOpen: Bool = Bool.random()) -> Bool {
    // TODO: Throw noInventory or noPower if shouldOpen is false
    return shouldOpen
  }
    
  func orderPastry(item: String, amountRequested: Int, flavor: String) -> Int {
    // TODO: Throw noSuchItem if itemsForSale[item] is nil
    let pastry = itemsForSale[item]!

    // TODO: Throw wrongFlavor if flavor isn't pastry.flavor


    // TODO: Throw tooFew(numberOnHand:) if there aren't enough to fill the order


    pastry.numberOnHand -= amountRequested
    return pastry.numberOnHand
  }
}

let bakery = Bakery()
// TODO: In a do closure, try open and orderPastry
bakery.open()
bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")

// TODO: In catch closures, handle BakeryError and other errors


//do {
//  try bakery.open()
//  try bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
//}
//// Another way to handle every error
//catch BakeryError.noInventory, BakeryError.noPower {
//  print("Sorry, the bakery is now closed.")
//} catch BakeryError.noSuchItem {
//  print("Sorry, but we don't sell this item.")
//} catch BakeryError.wrongFlavor {
//  print("Sorry, but we don't carry this flavor.")
//} catch BakeryError.tooFew(numberOnHand: let items) {
//  print("We only have \(items) of that item.")
//} catch {
//  print("Some other error.")
//}

// TODO: Use try? to wrap the result of a function in an optional.


// TODO: If you know for sure that your code is not going to fail, use try!


// This has the same effect as:
//do {
//  try bakery.open(true)
//  try bakery.orderPastry(item: "Cookie", amountRequested: 1, flavor: "ChocolateChip")
//}
//catch {
//  fatalError()
//}
