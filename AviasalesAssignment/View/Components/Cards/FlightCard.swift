import SwiftUI

struct FlightCard: View {
    let flight: FlightResult
    let itinerary: [City]
    let isCheapest: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 12) {
                header
                itineraryDetails
            }
            .padding(16)
            .background(AppColor.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if isCheapest {
                badge
            }
        }
        .padding(.top, isCheapest ? 16 : 0)
    }
    
    private var header: some View {
        VStack(spacing: 2) {
            HStack {
                Text("\(flight.price.formatted)")
                    .font(AppFont.title)
                    .foregroundStyle(AppColor.accentColor)
                Spacer()
                AppIcon.airlineLogo(for: flight.airline)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26, height: 26)
            }
            
            HStack {
                if flight.availableTicketsCount < 10 {
                    Text("Осталось \(flight.availableTicketsCount) билетов по этой цене")
                        .font(AppFont.body)
                        .foregroundStyle(AppColor.appRed)
                }
                Spacer()
            }
        }
    }
    
    private var itineraryDetails: some View {
        VStack(spacing: 12) {
            ItineraryRow(city: itinerary[0], dateString: flight.departure)
            ItineraryRow(city: itinerary[1], dateString: flight.arrival)
        }
    }
    
    private var badge: some View {
        Badge(text: "Самый дешёвый")
            .frame(height: 20)
            .offset(x: 8, y: -10)
    }
}

#Preview {
    ZStack {
        AppColor.accentColor.ignoresSafeArea()
        
        FlightCard(
            flight: FlightResult(
                id: "123",
                departure: "2023-09-03 20:25",
                arrival: "2023-09-03 21:45",
                price: Price(currency: "RUB", value: 17830),
                airline: "Аэрофлот",
                availableTicketsCount: 9
            ),
            
            itinerary: [
                City(iata: "MOW", name: "Москва"),
                City(iata: "LED", name: "Санкт-Петербург")
            ],
            isCheapest: true
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    ZStack {
        AppColor.accentColor.ignoresSafeArea()
        
        FlightCard(
            flight: FlightResult(
                id: "123",
                departure: "2023-09-03 10:25",
                arrival: "2023-09-03 12:45",
                price: Price(currency: "RUB", value: 212455),
                airline: "S7",
                availableTicketsCount: 17
            ),
            
            itinerary: [
                City(iata: "MOW", name: "Москва"),
                City(iata: "LED", name: "Санкт-Петербург")
            ],
            isCheapest: false
        )
        .padding(.horizontal, 16)
    }
}
