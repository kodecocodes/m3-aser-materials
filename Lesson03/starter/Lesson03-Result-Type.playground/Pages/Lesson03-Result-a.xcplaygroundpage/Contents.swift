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

import Foundation

enum EvenNumberError: Error {
  case emptyArray
}

// Function returns [Int], throws EvenNumberError
func evenNumbersThrow(in collection: [Int]) throws(EvenNumberError) -> [Int] {
  guard !collection.isEmpty else { throw .emptyArray }
  let evenNumbers = collection.filter { number in number % 2 == 0 }
  if evenNumbers.isEmpty {
    throw .emptyArray
  } else {
    return evenNumbers
  }
}

// TODO: Function returns Result<[Int], EvenNumberError>
func evenNumbers(in collection: [Int]) {

}

let emptyArray = [Int]()
let numbers: [Int] = [2,3,6,8,10]
let oddNumbers: [Int] = [1,3,5]

// TODO: Run evenNumbers with different arrays


// TODO: switch on result


// TODO: try result.get()


// Hacking With Swift: Task.result
func fetchReadings() async {
  let fetchTask = Task {
    let url = URL(string: "https://hws.dev/readings.json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let readings = try JSONDecoder().decode([Double].self, from: data)
    return "Found \(readings.count) readings"
  }
  let result = await fetchTask.result  // Note: don't need try

  // TODO: try result.get()


  // TODO: switch on result

}

//: [Next](@next)
