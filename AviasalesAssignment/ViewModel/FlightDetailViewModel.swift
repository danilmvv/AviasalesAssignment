import Foundation

final class FlightDetailViewModel: ObservableObject {
    var flight: FlightDetails
    
    init(flight: FlightDetails) {
        self.flight = flight
    }
}
