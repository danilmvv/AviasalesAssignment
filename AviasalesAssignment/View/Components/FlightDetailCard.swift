import SwiftUI

struct FlightDetailCard: View {
    let flight: FlightDetails
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 4) {
                airline
                itineraryDetails
            }
            .background(AppColor.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var airline: some View {
        HStack(spacing: 7) {
            AppIcon.airlineLogo(for: flight.airline)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
            
            Text("\(flight.airline)")
                .font(AppFont.headline)
                .foregroundStyle(AppColor.textPrimary)
            Spacer()
        }
        .padding(12)
    }
    
    private var itineraryDetails: some View {
        VStack(spacing: 12) {
            ItineraryRow(city: flight.itinerary[0], dateString: flight.departure)
            ItineraryRow(city: flight.itinerary[1], dateString: flight.arrival)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    ZStack {
        AppColor.accentColor.ignoresSafeArea()
        
        FlightDetailCard(
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
        .padding(.horizontal, 16)
    }
}
