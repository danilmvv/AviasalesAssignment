import SwiftUI

struct FlightDetailView: View {
    @StateObject private var viewModel: FlightDetailViewModel
    
    init(flight: FlightDetails) {
        _viewModel = StateObject(
            wrappedValue: FlightDetailViewModel(
                flight: flight
            )
        )
        
        AppLogger.view.info("Opened \(flight.airline) flight \(flight.id)")
    }
    
    var body: some View {
        ZStack {
            AppColor.appBackground.ignoresSafeArea()
            VStack(spacing: 0) {
                price
                flightTitle
                flightCard
                
                Spacer()
                
                buyButton
            }
            .alert("Билет куплен за \(viewModel.flight.price.formatted)", isPresented: $viewModel.showAlert) {
                Button("Отлично") { }
            }
        }
    }
    
    private var price: some View {
        VStack(spacing: 4) {
            Text("\(viewModel.flight.price.formatted)")
                .font(AppFont.largeTitle)
            Text("Лучшая цена за \(viewModel.flight.passengerCount) чел")
                .font(AppFont.body)
        }
        .padding(.bottom, 32)
    }
    
    private var flightTitle: some View {
        HStack {
            Text("\(viewModel.flight.itinerary[0].name) — \(viewModel.flight.itinerary[1].name)")
                .font(AppFont.flightTitle)
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var flightCard: some View {
        FlightDetailCard(flight: viewModel.flight)
            .padding(16)
    }
    
    private var buyButton: some View {
        BuyButton(title: "Купить билет за \(viewModel.flight.price.formatted)") {
            viewModel.buyFlight()
        }
        .padding(8)
    }
}

#Preview {
    FlightDetailView(
        flight: FlightDetails(
            id: "123",
            departure: "2023-09-03 20:25",
            arrival: "2023-09-03 21:45",
            price: Price(currency: "RUB", value: 17830),
            airline: "Аэрофлот",
            itinerary: [
                City(iata: "MOW", name: "Москва"),
                City(iata: "LED", name: "Санкт-Петербург")
            ],
            passengerCount: 1
        )
    )
}
