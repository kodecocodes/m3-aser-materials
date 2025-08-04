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

// Failable initializers
// Int() can return nil
let value = Int("3")
let failedValue = Int("nope")

// Compiler creates failable init for raw representable enum
enum PetFood: String {
  case kibble, canned
}

let morning = PetFood(rawValue: "kibble")
let snack = PetFood(rawValue: "fuuud!")

// Create your own failable init
// Instance has correct properties or doesn't exist
struct PetHouse {
  let squareFeet: Int

  // TODO: Create your own failable init
}

//let house = PetHouse(squareFeetAsString: "100")
//let nopeHouse = PetHouse(squareFeetAsString: "nope")


// Optional chaining
/*
 A lot of Kodeco team members own pets — but not all. Some pets have a favorite toy, and others don’t. Some of these toys make noise, and others don’t.
 */
class Toy {
    
  enum Kind {
    case ball, zombie, bone, mouse
  }
    
  enum Sound {
    case squeak, bell
  }
    
  let kind: Kind
  let color: String
  var sound: Sound?
    
  init(kind: Kind, color: String, sound: Sound? = nil) {
    self.kind = kind
    self.color = color
    self.sound = sound
  }
}

class Pet {
    
  enum Kind {
    case dog, cat, guineaPig
  }
    
  let name: String
  let kind: Kind
  let favoriteToy: Toy?
    
  init(name: String, kind: Kind, favoriteToy: Toy? = nil) {
    self.name = name
    self.kind = kind
    self.favoriteToy = favoriteToy
  }
}

class Person {
  let pet: Pet?
    
  init(pet: Pet? = nil) {
    self.pet = pet
  }
}

let janie = Person(pet: Pet(name: "Delia", kind: .dog, favoriteToy: Toy(kind: .ball, color: "Purple", sound: .bell)))
let tammy = Person(pet: Pet(name: "Evil Cat Overlord", kind: .cat, favoriteToy: Toy(kind: .mouse, color: "Orange")))
let felipe = Person()

// TODO: Add code to print sound of favoriteToy of pet of each Person

//: [Next](@next)
