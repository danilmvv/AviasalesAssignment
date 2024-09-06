import Foundation

@MainActor
class FlightListViewModel: ObservableObject {
    @Published var passengerCount: Int = 0
    @Published var departureDate: String = ""
    @Published var origin: City = City(iata: "MOW", name: "Москва")
    @Published var destination: City = City(iata: "LED", name: "Санкт-Петербург")
    @Published var flights = [FlightResult]()
    
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
            self.flights = response.results
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
