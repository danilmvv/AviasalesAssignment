import Foundation

final class NetworkManager {
    private let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try endpoint.createURLRequest(baseURL: baseUrl)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
            } catch {
                throw error
            }
        case 400:
            throw NetworkError.badRequest
        case 404:
            throw NetworkError.notFound
        case 500:
            throw NetworkError.server
        default:
            throw NetworkError.requestFailed(httpResponse.statusCode)
        }
    }
}
