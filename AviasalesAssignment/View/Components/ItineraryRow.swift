import SwiftUI

struct ItineraryRow: View {
    let city: City
    let dateString: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(city.name)
                
                Spacer()
                
                if let date = Date(from: dateString) {
                    Text(date.timeOnly)
                }
            }
            .fontWeight(.bold)
            
            HStack {
                Text(city.iata)
                
                Spacer()
                
                if let date = Date(from: dateString) {
                    Text(date.dayWeekday)
                }
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
    }
}

#Preview {
    ItineraryRow(city: City(iata: "MOW", name: "Москва"), dateString: "2023-09-03 20:25")
}
