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

func fetchData(
  from urlString: String,
  completion: @escaping @Sendable (FetchResult) -> Void) {
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

//: [Next](@next)
