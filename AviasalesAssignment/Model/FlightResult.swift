import Foundation

struct FlightResult: Codable {
    let id: String
    let departure: String
    let arrival: String
    let price: Price
    let airline: String
    let availableTicketsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case departure = "departure_date_time"
        case arrival = "arrival_date_time"
        case price
        case airline
        case availableTicketsCount = "available_tickets_count"
    }
}
