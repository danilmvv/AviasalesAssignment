import Foundation

@MainActor
class FlightListViewModel: ObservableObject {
    @Published var passengerCount: Int = 0
    @Published var departureDate: String = ""
    @Published var origin: City = City(iata: "", name: "")
    @Published var destination: City = City(iata: "", name: "")
    @Published var flights = [FlightResult]()
    @Published var cheapestFlightID: String?
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchFlights(origin: String = "MOW", destination: String = "LED") async {
        isLoading = true
        errorMessage = nil
        
        let endpoint = FlightSearchEndpoint(origin: origin, destination: destination)
        
        do {
            let response = try await networkManager.request(endpoint, responseType: SearchResponse.self)
            
            self.passengerCount = response.passengersCount
            self.departureDate = response.results.first?.departure ?? ""
            self.origin = response.origin
            self.destination = response.destination
            self.flights = response.results.sorted { $0.price.value < $1.price.value }
            self.cheapestFlightID = self.flights.first?.id
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func getFlightDetails(flight: FlightResult) -> FlightDetails {
        return FlightDetails(
            id: flight.id,
            departure: flight.departure,
            arrival: flight.arrival,
            price: flight.price,
            airline: flight.airline,
            itinerary: [origin, destination],
            passengerCount: passengerCount
        )
    }
}
