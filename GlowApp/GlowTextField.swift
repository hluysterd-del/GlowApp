import SwiftUI

struct GlowTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    @FocusState private var isFocused: Bool

    var body: some View {
        Group {
            if isSecure {
                SecureField("", text: $text)
                    .focused($isFocused)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(Color.white.opacity(0.3))
                    }
            } else {
                TextField("", text: $text)
                    .focused($isFocused)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundColor(Color.white.opacity(0.3))
                    }
            }
        }
        .foregroundColor(.white)
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            isFocused
                                ? Color(red: 0, green: 0.83, blue: 1).opacity(0.6)
                                : Color.white.opacity(0.1),
                            lineWidth: 1
                        )
                )
                .shadow(
                    color: isFocused
                        ? Color(red: 0, green: 0.83, blue: 1).opacity(0.2)
                        : Color.clear,
                    radius: 8, x: 0, y: 0
                )
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .onTapGesture {
            isFocused = true
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
