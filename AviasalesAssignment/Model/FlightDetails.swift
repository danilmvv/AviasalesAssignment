import Foundation

struct FlightDetails: Hashable {
    let id: String
    let departure: String
    let arrival: String
    let price: Price
    let airline: String
    let itinerary: [City]
    let passengerCount: Int
}
