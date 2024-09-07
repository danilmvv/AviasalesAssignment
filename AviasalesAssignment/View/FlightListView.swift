import SwiftUI

struct FlightListView: View {
    @StateObject private var viewModel: FlightListViewModel
    
    init(networkManager: NetworkManager) {
        _viewModel = StateObject(wrappedValue: FlightListViewModel(networkManager: networkManager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.appBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.flights, id: \.id) { flight in
                            NavigationLink(value: viewModel.getFlightDetails(flight: flight), label: {
                                FlightCard(
                                    flight: flight,
                                    itinerary: [
                                        viewModel.origin,
                                        viewModel.destination
                                    ],
                                    isCheapest: flight.id == viewModel.cheapestFlightID
                                )
                                .padding(.horizontal, 16)
                            })
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
            .navigationDestination(for: FlightDetails.self) { flight in
                FlightDetailView(flight: flight)
            }
            .navigationTitle("Все билеты")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("\(viewModel.origin.name) — \(viewModel.destination.name)")
                            .font(AppFont.headline)
                            .foregroundStyle(AppColor.textPrimary)
                        if let departureDate = Date(from: viewModel.departureDate) {
                            Text("\(departureDate.dayMonth), \(viewModel.passengerCount) чел")
                                .font(AppFont.subheadline)
                                .foregroundStyle(AppColor.textSecondary)
                                .transition(.scale)
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
