import SwiftUI

@main
struct DrinkUpApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CocktailListView()
        }
    }
}
