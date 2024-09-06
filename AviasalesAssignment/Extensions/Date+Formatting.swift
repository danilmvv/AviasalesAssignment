import Foundation

extension Date {
    private enum DateFormat: String {
        case server = "yyyy-MM-dd HH:mm"
        case dayMonth = "d MMMM"              // 3 сентября
        case dayWeekday = "d MMM, EEE"        // 3 сен, пн (на самом деле "3 сент., пн")
        case timeOnly = "HH:mm"               // 20:50
    }
    
    private func format(_ dateFormat: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = dateFormat.rawValue
        
        // Небольшой костыль для отображения даты как в макете
        if dateFormat == .dayWeekday {
            let formattedString = formatter.string(from: self)
            let components = formattedString.split(separator: " ")
            let day = components[0]
            let month = String(components[1].prefix(3))
            let weekday = components[2].lowercased()
            
            return "\(day) \(month), \(weekday)"
        }
        
        return formatter.string(from: self)
    }
    
    var dayMonth: String {
        return format(.dayMonth)
    }
    
    var dayWeekday: String {
        return format(.dayWeekday)
    }
    
    var timeOnly: String {
        return format(.timeOnly)
    }
    
    init?(from dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.server.rawValue
        if let date = formatter.date(from: dateString) {
            self = date
        } else {
            return nil
        }
    }
}
