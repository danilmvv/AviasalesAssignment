import Foundation

struct Price: Codable {
    let currency: String
    let value: Double
}

extension Price {
    var formatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.maximumFractionDigits = 0

        guard let formattedValue = numberFormatter.string(from: NSNumber(value: value)) else {
            return "\(value) \(currencySymbol)"
        }
        
        return "\(formattedValue) \(currencySymbol)"
    }

    private var currencySymbol: String {
        switch currency {
        case "RUB":
            return "₽"
        default:
            return currency
        }
    }
}
