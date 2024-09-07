import Foundation

struct AppLogger {
    enum Category: String, CaseIterable {
        case view = "UI"
        case network = "Network"
        case data = "Data"
    }
    
    public static let view = CategoryLogger(category: .view)
    public static let network = CategoryLogger(category: .network)
    public static let data = CategoryLogger(category: .data)
}
