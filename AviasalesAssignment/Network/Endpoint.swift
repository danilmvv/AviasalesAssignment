import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String : String]? { get }
}

extension Endpoint {
    func createURLRequest(baseURL: URL) throws -> URLRequest {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw NetworkError.badURL
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        return request
    }
}
