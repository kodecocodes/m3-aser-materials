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

import Foundation

// Examples of pre-Swift-Concurrency use of Result
// Saurabh Patel (DhiWise): Completion handler
enum DataFetchError: Error {
  case networkFailure
  case dataCorrupted
  case unauthorized
}

// Define a Result type for fetching data
typealias FetchResult = Result<Data, DataFetchError>

func fetchData(from urlString: String, completion: @escaping @Sendable (FetchResult) -> Void) {
  guard let url = URL(string: urlString) else {
    completion(.failure(.networkFailure))
    return
  }

  // Simulate fetching data
  URLSession.shared.dataTask(with: url) { data, response, error in
    guard let data = data else {
      completion(.failure(.dataCorrupted))
      return
    }
    completion(.success(data))
  }.resume()
}

// Handling the result of fetchData
fetchData(from: "https://example.com") { result in
  switch result {
  case .success(let data):
    print("Successfully fetched \(data.count) bytes.")
  case .failure(let error):
    switch error {
    case .networkFailure:
      print("Network failure - Please check your connection.")
    case .dataCorrupted:
      print("Data corrupted - Unable to process the data received.")
    case .unauthorized:
      print("Unauthorized - Access denied.")
    }
  }
}

// Function that returns Result type
enum JSONError: Error {
  case invalidURL
  case networkError(Error)
  case parsingError(Error)
}

// Function returns a dictionary on success or an error on failure
func loadJSON(fromURL urlString: String) -> Result<[String: Any], JSONError> {
  guard let url = URL(string: urlString) else {
    return .failure(.invalidURL)
  }

  do {
    let data = try Data(contentsOf: url)
    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
    guard let dictionary = jsonObject as? [String: Any] else {
      return .failure(.parsingError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parsing failed"])))
    }
    return .success(dictionary)
  } catch let error as NSError {
    return .failure(.networkError(error))
  }
}

// Handle Result from loadJSON
func handleJSONResult(urlString: String) {
  let result = loadJSON(fromURL: urlString)

  switch result {
  case .success(let dictionary):
    print("JSON loaded successfully: \(dictionary)")
  case .failure(let error):
    switch error {
    case .invalidURL:
      print("Invalid URL provided.")
    case .networkError(let networkError):
      print("Network error occurred: \(networkError.localizedDescription)")
    case .parsingError(let parsingError):
      print("Error parsing the data: \(parsingError.localizedDescription)")
    }
  }
}

// Apple: Writing Failable Asynchronous APIs
enum EntropyError: Error {
  case entropyDepleted
}

let queue = DispatchQueue(label: "com.example.queue")

struct AsyncRandomGenerator {
  static let entropyLimit = 5
  var count = 0

  mutating func fetchRemoteRandomNumber(
    completion: @escaping @Sendable (Result<Int, EntropyError>) -> Void
  ) {
    let result: Result<Int, EntropyError>
    if count < AsyncRandomGenerator.entropyLimit {
      // Produce numbers until reaching the entropy limit.
      result = .success(Int.random(in: 1...100))
    } else {
      // Supply a failure reason when the caller hits the limit.
      result = .failure(.entropyDepleted)
    }
    count += 1

    // Delay to simulate an asynchronous source of entropy.
    queue.asyncAfter(deadline: .now() + 2) {
      completion(result)
    }
  }
}

var generator = AsyncRandomGenerator()
// Request one more number than the limit to trigger a failure.
(0..<AsyncRandomGenerator.entropyLimit + 1).forEach { _ in
  generator.fetchRemoteRandomNumber { result in
    switch result {
    case .success(let number):
      print(number)
    case .failure(let error):
      print("Source of randomness failed: \(error)")
    }
  }
}

//: [Next](@next)
