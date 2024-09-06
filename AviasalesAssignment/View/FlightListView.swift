import SwiftUI

struct FlightListView: View {
    @StateObject private var viewModel: FlightListViewModel
    
    init(networkManager: NetworkManager) {
        _viewModel = StateObject(wrappedValue: FlightListViewModel(networkManager: networkManager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.flights, id: \.id) { flight in
                            FlightCard(
                                flight: flight,
                                itinerary: [
                                    viewModel.origin,
                                    viewModel.destination
                                ]
                            )
                            .padding(.horizontal, 16)
                        }
                        .overlay {
                            if viewModel.isLoading {
                                ProgressView("Загрузка...")
                            } else if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage).foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Все билеты")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if let departureDate = Date(from: viewModel.departureDate) {
                        VStack {
                            Text("\(viewModel.origin.name) – \(viewModel.destination.name)")
                            Text("\(departureDate.dayMonth), \(viewModel.passengerCount) чел")
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchFlights()
                }
            }
        }
    }
}

#Preview {
    FlightListView(networkManager: NetworkManager(baseUrl: URL(string: "https://nu.vsepoka.ru/api")!))
}
