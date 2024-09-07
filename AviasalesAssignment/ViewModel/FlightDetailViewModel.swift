import Foundation

final class FlightDetailViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    
    var flight: FlightDetails
    
    init(flight: FlightDetails) {
        self.flight = flight
    }
    
    func buyFlight() {
        showAlert = true
    }
}
