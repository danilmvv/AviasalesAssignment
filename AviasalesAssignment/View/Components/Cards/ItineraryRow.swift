import SwiftUI

struct ItineraryRow: View {
    let city: City
    let dateString: String
    
    var body: some View {
        VStack(alignment: .leading) {
            topRow
            bottomRow
        }
    }
    
    private var topRow: some View {
        HStack {
            Text(city.name)
            
            Spacer()
            
            if let date = Date(from: dateString) {
                Text(date.timeOnly)
            }
        }
        .font(AppFont.headline)
    }
    
    private var bottomRow: some View {
        HStack {
            Text(city.iata)
            
            Spacer()
            
            if let date = Date(from: dateString) {
                Text(date.dayWeekday)
            }
        }
        .font(AppFont.body)
        .foregroundColor(AppColor.textSecondary)
    }
}

#Preview {
    ZStack {
        ItineraryRow(city: City(iata: "MOW", name: "Москва"), dateString: "2023-09-03 20:25")
            .padding()
    }
}
