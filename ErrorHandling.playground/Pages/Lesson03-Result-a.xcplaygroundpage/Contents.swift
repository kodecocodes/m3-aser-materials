//: [Previous](@previous)

import Foundation

// Simple use of Result
enum EvenNumberError: Error {
  case emptyArray
}

func evenNumbers(in collection: [Int]) -> Result<[Int], EvenNumberError> {
  guard !collection.isEmpty else {
    return .failure(EvenNumberError.emptyArray)
  }
  
  let evenNumbers = collection.filter { number in number % 2 == 0 }
  
  if evenNumbers.isEmpty {
    return .failure(EvenNumberError.emptyArray)
  } else {
    return .success(evenNumbers)
  }
}

let numbers: [Int] = [2,3,6,8,10]
let oddNumbers: [Int] = [1,3,5]
let emptyArray = [Int]()

print(evenNumbers(in: numbers))
print(evenNumbers(in: oddNumbers))


// Paul Hudson: Task.result
func fetchReadings() async {
  let fetchTask = Task {
    let url = URL(string: "https://hws.dev/readings.json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let readings = try JSONDecoder().decode([Double].self, from: data)
    return "Found \(readings.count) readings"
  }
  let result = await fetchTask.result  // Note: don't need try

  // read result
  do {
    let output = try result.get()
  } catch {
    let output = "Error: \(error.localizedDescription)"
  }

  // or switch
  switch result {
  case .success(let str):
    let output = str
  case .failure(let error):
    let output = "Error: \(error.localizedDescription)"
  }
}

//: [Next](@next)
