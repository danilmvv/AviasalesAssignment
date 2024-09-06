import SwiftUI

@main
struct AviasalesAssignmentApp: App {
    private let networkManager = NetworkManager(baseUrl: URL(string: "https://nu.vsepoka.ru/api")!)
    
    var body: some Scene {
        WindowGroup {
            FlightListView(networkManager: networkManager)
        }
    }
}
