import SwiftUI

struct FlightCard: View {
    let flight: FlightResult
    let itinerary: [City]
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("\(flight.price.formatted)")
                Spacer()
                Text(flight.airline)
            }
            
            VStack {
                ItineraryRow(city: itinerary[0], dateString: flight.departure)
                ItineraryRow(city: itinerary[1], dateString: flight.arrival)
            }
        }
        .padding(16)
//        .background(Color.red)
    }
}

#Preview {
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
        ]
    )
}
