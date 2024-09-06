import Foundation

struct SearchResponse: Codable {
    let passengersCount: Int
    let origin: City
    let destination: City
    let results: [FlightResult]
    
    enum CodingKeys: String, CodingKey {
        case passengersCount = "passengers_count"
        case origin
        case destination
        case results
    }
}
