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
