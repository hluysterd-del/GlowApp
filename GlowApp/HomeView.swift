import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var contentOpacity: Double = 0
    @State private var showSignOutConfirm = false
    @State private var emptyPulse = false

    private let cyanColor = Color(red: 0, green: 0.83, blue: 1)

    var body: some View {
        ZStack {
            GlowBackground()

            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome back,")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color.white.opacity(0.4))
                        Text(authManager.currentUsername)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    // Profile / Sign Out
                    Button(action: {
                        showSignOutConfirm = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.06))
                                .frame(width: 42, height: 42)
                                .overlay(
                                    Circle()
                                        .stroke(cyanColor.opacity(0.2), lineWidth: 1)
                                )

                            Text(String(authManager.currentUsername.prefix(1)).uppercased())
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(cyanColor)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 8)

                // Divider
                Rectangle()
                    .fill(Color.white.opacity(0.06))
                    .frame(height: 1)
                    .padding(.horizontal, 24)

                Spacer()

                // Empty State
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .stroke(cyanColor.opacity(emptyPulse ? 0.15 : 0.05), lineWidth: 1)
                            .frame(width: 100, height: 100)
                            .shadow(color: cyanColor.opacity(0.15), radius: emptyPulse ? 15 : 5)

                        Image(systemName: "tray")
                            .font(.system(size: 36, weight: .light))
                            .foregroundColor(Color.white.opacity(0.2))
                    }

                    Text("Nothing here yet")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.3))

                    Text("This is where the magic will happen.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color.white.opacity(0.15))
                }

                Spacer()
            }
            .opacity(contentOpacity)
        }
        .alert("Sign Out", isPresented: $showSignOutConfirm) {
            Button("Cancel", role: .cancel) {}
            Button("Sign Out", role: .destructive) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    authManager.signOut()
                }
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                contentOpacity = 1
            }
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                emptyPulse = true
            }
        }
    }
}
