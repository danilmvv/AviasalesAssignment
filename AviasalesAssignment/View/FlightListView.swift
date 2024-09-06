import SwiftUI

struct FlightListView: View {
    @StateObject private var viewModel: FlightListViewModel
    
    init(networkManager: NetworkManager) {
        _viewModel = StateObject(wrappedValue: FlightListViewModel(networkManager: networkManager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("\(viewModel.origin.name) – \(viewModel.destination.name)")
                    Text("\(viewModel.departureDate) \(viewModel.passengerCount) чел")
                    List(viewModel.flights, id: \.id) { flight in
                        FlightCard(flight: flight)
                    }
                    .overlay {
                        if viewModel.isLoading {
                            ProgressView("Загрузка...")
                        } else if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage).foregroundColor(.red)
                        }
                    }
                }
                .navigationTitle("Все билеты")
                .toolbar(.hidden)
                .onAppear {
                    Task {
                        await viewModel.fetchFlights()
                    }
            }
            }
        }
    }
}

#Preview {
    FlightListView(networkManager: NetworkManager(baseUrl: URL(string: "https://nu.vsepoka.ru/api")!))
}
