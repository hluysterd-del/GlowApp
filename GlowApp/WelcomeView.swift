import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var logoOpacity: Double = 0
    @State private var logoScale: CGFloat = 0.8
    @State private var titleOpacity: Double = 0
    @State private var subtitleOpacity: Double = 0
    @State private var buttonOpacity: Double = 0
    @State private var glowPulse = false

    private let cyanColor = Color(red: 0, green: 0.83, blue: 1)

    var body: some View {
        ZStack {
            GlowBackground()

            VStack(spacing: 0) {
                Spacer()

                // Logo / Icon
                ZStack {
                    // Outer glow ring
                    Circle()
                        .stroke(cyanColor.opacity(glowPulse ? 0.3 : 0.1), lineWidth: 2)
                        .frame(width: 120, height: 120)
                        .shadow(color: cyanColor.opacity(0.3), radius: glowPulse ? 20 : 10)

                    // Inner icon
                    Image(systemName: "sparkles")
                        .font(.system(size: 44, weight: .light))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [cyanColor, cyanColor.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: cyanColor.opacity(0.5), radius: 10)
                }
                .opacity(logoOpacity)
                .scaleEffect(logoScale)

                Spacer().frame(height: 40)

                // Title
                Text("Welcome")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(titleOpacity)

                Spacer().frame(height: 12)

                // Subtitle
                Text("Your space. Your vibe.")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.white.opacity(0.5))
                    .opacity(subtitleOpacity)

                Spacer()

                // Buttons
                VStack(spacing: 14) {
                    GlowButton(title: "Create Account") {
                        authManager.markWelcomeSeen()
                    }

                    GlowButtonOutline(title: "I Already Have an Account") {
                        authManager.markWelcomeSeen()
                    }
                }
                .padding(.horizontal, 30)
                .opacity(buttonOpacity)

                Spacer().frame(height: 50)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
                logoOpacity = 1
                logoScale = 1
            }
            withAnimation(.easeOut(duration: 0.6).delay(0.6)) {
                titleOpacity = 1
            }
            withAnimation(.easeOut(duration: 0.6).delay(0.9)) {
                subtitleOpacity = 1
            }
            withAnimation(.easeOut(duration: 0.6).delay(1.2)) {
                buttonOpacity = 1
            }
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true).delay(1.0)) {
                glowPulse = true
            }
        }
    }
}
