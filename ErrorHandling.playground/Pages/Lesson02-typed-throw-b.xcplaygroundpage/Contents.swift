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

func loadFeed() throws { }  // equivalent to func loadFeed() throws(any Error)

do {
  try loadFeed()
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

// Not allowed: func loadFeed() throws(AuthError, NetworkError)

enum FeedError: Error {
  case authError(AuthError)
  case networkError(NetworkError)
  // include 'other' if you need flexibility
  // case other(any Error)
}

func loadFeed2() throws(FeedError) { }

do {
  try loadFeed2()
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
  try loadFeed2()
  try cacheFeed()
} catch {
  // error is any Error here
}

//: [Next](@next)
