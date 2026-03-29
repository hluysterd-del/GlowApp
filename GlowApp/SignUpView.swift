import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authManager: AuthManager
    @Binding var showSignUp: Bool
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var contentOpacity: Double = 0

    private let cyanColor = Color(red: 0, green: 0.83, blue: 1)

    var body: some View {
        ZStack {
            GlowBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 60)

                    // Header
                    VStack(spacing: 8) {
                        Text("Create Account")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text("Join the experience")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Color.white.opacity(0.4))
                    }

                    Spacer().frame(height: 40)

                    // Form
                    VStack(spacing: 16) {
                        GlowTextField(placeholder: "Username", text: $username)
                        GlowTextField(placeholder: "Email", text: $email)
                        GlowTextField(placeholder: "Password", text: $password, isSecure: true)
                        GlowTextField(placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)
                    }
                    .padding(.horizontal, 30)

                    // Error
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color.red.opacity(0.8))
                            .padding(.top, 12)
                            .transition(.opacity)
                    }

                    Spacer().frame(height: 30)

                    // Sign Up Button
                    GlowButton(title: "Create Account") {
                        handleSignUp()
                    }
                    .padding(.horizontal, 30)

                    Spacer().frame(height: 24)

                    // Switch to Sign In
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showSignUp = false
                        }
                    }) {
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .foregroundColor(Color.white.opacity(0.4))
                            Text("Sign In")
                                .foregroundColor(cyanColor)
                                .fontWeight(.semibold)
                        }
                        .font(.system(size: 14))
                    }

                    Spacer().frame(height: 40)
                }
            }
            .opacity(contentOpacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
                contentOpacity = 1
            }
        }
    }

    private func handleSignUp() {
        withAnimation(.easeInOut(duration: 0.2)) {
            errorMessage = ""
        }

        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            withAnimation { errorMessage = "Please fill in all fields" }
            return
        }
        guard password == confirmPassword else {
            withAnimation { errorMessage = "Passwords don't match" }
            return
        }
        guard password.count >= 6 else {
            withAnimation { errorMessage = "Password must be at least 6 characters" }
            return
        }

        let success = authManager.signUp(username: username, email: email, password: password)
        if !success {
            withAnimation { errorMessage = "An account with this email already exists" }
        }
    }
}
