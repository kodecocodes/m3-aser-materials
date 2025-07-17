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

  init?(squareFeetAsString: String) {
    guard let squareFeet = Int(squareFeetAsString) else {
      return nil
    }
    self.squareFeet = squareFeet
  }
}

let nopeHouse = PetHouse(squareFeetAsString: "nope")
let house = PetHouse(squareFeetAsString: "100")


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

if let sound = janie.pet?.favoriteToy?.sound {
  print("Sound \(sound).")
} else {
  print("No sound.")
}

if let sound = tammy.pet?.favoriteToy?.sound {
  print("Sound \(sound).")
} else {
  print("No sound.")
}

if let sound = felipe.pet?.favoriteToy?.sound {
  print("Sound \(sound).")
} else {
  print("No sound.")
}
