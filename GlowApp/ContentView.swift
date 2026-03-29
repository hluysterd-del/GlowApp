import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        Group {
            if authManager.isLoggedIn {
                HomeView()
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            } else if !authManager.hasSeenWelcome {
                WelcomeView()
                    .transition(.opacity.combined(with: .scale))
            } else {
                SignInView()
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            }
        }
        .animation(.easeInOut(duration: 0.5), value: authManager.isLoggedIn)
        .animation(.easeInOut(duration: 0.5), value: authManager.hasSeenWelcome)
    }
}
