import SwiftUI

struct GlowBackground: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.04, blue: 0.06)
                .ignoresSafeArea()

            // Primary cyan glow - top right
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 0, green: 0.83, blue: 1).opacity(0.15),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 250
                    )
                )
                .frame(width: 500, height: 500)
                .offset(x: 120, y: animate ? -200 : -220)
                .blur(radius: 60)

            // Secondary blue glow - bottom left
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 0, green: 0.4, blue: 1).opacity(0.1),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .offset(x: -100, y: animate ? 300 : 280)
                .blur(radius: 50)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}
