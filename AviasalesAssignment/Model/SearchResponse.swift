import Foundation

struct SearchResponse: Codable {
    let passengerCount: Int
    let origin: City
    let destination: City
    let results: [FlightResult]
    
    enum CodingKeys: String, CodingKey {
        case passengerCount = "passenger_count"
        case origin
        case destination
        case results
    }
}
