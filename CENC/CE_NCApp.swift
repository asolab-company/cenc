import SwiftUI

@main
struct CE_NCApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView(onFinish: { showSplash = false })
            } else {
                MainView()
            }
        }
    }
}
