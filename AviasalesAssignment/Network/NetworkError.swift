import Foundation

enum NetworkError: Error {
    case badRequest // 400
    case notFound // 404
    case server // 500
    case badURL
    case requestFailed(Int)
    case unknown

    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Invalid request."
        case .notFound:
            return "Not found."
        case .server:
            return "Internal server error."
        case .badURL:
            return "Bad URL"
        case .requestFailed(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .unknown:
            return "Unknown error."
        }
    }
}
