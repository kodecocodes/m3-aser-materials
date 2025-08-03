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

enum NetworkError: Error {
  case unexpected
  case disconnected
  case timeout(seconds: Int)
  case invalidURL(_ url: URL)
  case httpError(statusCode: Int)
}

enum AuthError: Error {
  case missingToken
  case tokenExpired
}

func performNetworkRequest() throws(NetworkError) {
  throw .disconnected
}

do {
  try performNetworkRequest()
} catch .disconnected {
  print("You are not connected to the internet.")
} catch .timeout(let seconds) {
  print("The request timed out after \(seconds) seconds.")
} catch .httpError(let statusCode) {
  print("HTTP Error with status code: \(statusCode).")
} catch {  // never happens
  print("An unexpected error occurred.")
}

// Not allowed: function can throw at most one Error type
//func loadData() throws(NetworkError, AuthError) {  // Consecutive statements on a line...
func loadData() throws {
  // networking code can throw NetworkError
  // authentication code can throw AuthError
}

// Fall back to untyped throw
do {
  try loadData()
}
catch let authError as AuthError {
  print("auth error", authError)
  switch authError {
  case .missingToken:
    print("missing token")
    // present a login screen
  case .tokenExpired:
    print("token expired")
    // attempt a token refresh
  }
}
catch let networkError as NetworkError {
  print("network error", networkError)
  // present alert explaining what went wrong
}
catch {
  print("error", error)
}

// Combine Error types
enum FeedError: Error {
  case authError(AuthError)
  case networkError(NetworkError)
  // include 'other' if you need flexibility
  // case other(any Error)
}

func loadData2() throws(FeedError) { }

do {
  try loadData2()
}
catch {
  switch error {
  case .authError(let authError):
    // handle auth error
  case .networkError(let networkError):
    // handle network error
  }
}

func cacheFeed() throws { }

// Two methods might throw different error types so the compiler must drop down to any Error
// since both methods throw something that conforms to Error
do {
  try loadData2()
  try cacheFeed()
} catch {
  // error is any Error here
}
