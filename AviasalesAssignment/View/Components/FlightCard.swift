import SwiftUI

struct FlightCard: View {
    let flight: FlightResult
    
    var body: some View {
        VStack {
            HStack {
                Text("\(Int(flight.price.value)) \(flight.price.currency)")
                Spacer()
                Text(flight.airline)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Text(flight.departure)
                }
                
                HStack {
                    Spacer()
                    Text(flight.arrival)
                }
            }
        }
        .padding()
    }
}

#Preview {
    FlightCard(
        flight: FlightResult(
            id: "123",
            departure: "12:55; 3 сен, пн",
            arrival: "15:10; 3 сен, пн",
            price: Price(currency: "₽", value: 17830),
            airline: "Аэрофлот",
            availableTicketsCount: 9
        )
    )
}
