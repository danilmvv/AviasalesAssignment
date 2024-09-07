import Foundation
import Dependencies

private enum NetworkManagerKey: DependencyKey {
    static let liveValue = NetworkManager(baseUrl: URL(string: "https://nu.vsepoka.ru/api")!)
}

extension DependencyValues {
    var networkManager: NetworkManager {
        get { self[NetworkManagerKey.self] }
        set { self[NetworkManagerKey.self] = newValue }
    }
}

final class NetworkManager {
    private let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        let request = try endpoint.createURLRequest(baseURL: baseUrl)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            AppLogger.network.error("Invalid HTTP Response")
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            AppLogger.network.debug("Successful request \(httpResponse.statusCode)")
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                return decodedResponse
            } catch {
                throw error
            }
        case 400:
            AppLogger.network.error("Bad request \(httpResponse.statusCode)")
            throw NetworkError.badRequest
        case 404:
            AppLogger.network.error("Not found \(httpResponse.statusCode)")
            throw NetworkError.notFound
        case 500:
            AppLogger.network.error("Internal server error \(httpResponse.statusCode)")
            throw NetworkError.server
        default:
            AppLogger.network.error("Fail \(httpResponse.statusCode)")
            throw NetworkError.requestFailed(httpResponse.statusCode)
        }
    }
}
