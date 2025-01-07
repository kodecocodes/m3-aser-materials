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

enum NetworkError: Error, LocalizedError, Identifiable {
  case invalidURL
  case noData
  case decodingFailed
  case unexpectedStatusCode(Int)
  
  // Identifiable conformance
  var id: String {
    switch self {
    case .invalidURL: return "invalidURL"
    case .noData: return "noData"
    case .decodingFailed: return "decodingFailed"
    case .unexpectedStatusCode(let code): return "unexpectedStatusCode_\(code)"
    }
  }
  
  // LocalizedError conformance
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "The URL provided is invalid."
    case .noData:
      return "No data was received from the server."
    case .decodingFailed:
      return "Failed to decode the response."
    case .unexpectedStatusCode(let code):
      return "Unexpected status code: \(code)."
    }
  }  
}

protocol NetworkService {
  func fetchUsers() async throws -> [User]
}

class DefaultNetworkManager: NetworkService {
  func fetchUsers() async throws -> [User] {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
      throw NetworkError.invalidURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.unexpectedStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)
    }

    do {
      return try JSONDecoder().decode([User].self, from: data)
    } catch {
      throw NetworkError.decodingFailed
    }
  }
}
