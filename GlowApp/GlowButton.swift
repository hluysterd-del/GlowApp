import SwiftUI

struct GlowButton: View {
    let title: String
    let action: () -> Void
    @State private var isPressed = false

    private let cyanColor = Color(red: 0, green: 0.83, blue: 1)

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(
                            LinearGradient(
                                colors: [
                                    cyanColor,
                                    cyanColor.opacity(0.8)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .shadow(color: cyanColor.opacity(0.4), radius: 12, x: 0, y: 4)
                .scaleEffect(isPressed ? 0.97 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.15)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

struct GlowButtonOutline: View {
    let title: String
    let action: () -> Void

    private let cyanColor = Color(red: 0, green: 0.83, blue: 1)

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(cyanColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(cyanColor.opacity(0.5), lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(cyanColor.opacity(0.05))
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
