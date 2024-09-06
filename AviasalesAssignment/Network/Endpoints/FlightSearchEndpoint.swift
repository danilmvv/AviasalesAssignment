import Foundation

struct FlightSearchEndpoint: Endpoint {
    let origin: String
    let destination: String
    
    var path: String {
        return "/search"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "origin", value: origin),
            URLQueryItem(name: "destination", value: destination)
        ]
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
