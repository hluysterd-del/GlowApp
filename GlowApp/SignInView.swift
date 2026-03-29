import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var showSignUp = false
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var contentOpacity: Double = 0

    private let cyanColor = Color(red: 0, green: 0.83, blue: 1)

    var body: some View {
        ZStack {
            if showSignUp {
                SignUpView(showSignUp: $showSignUp)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
            } else {
                signInContent
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: showSignUp)
    }

    private var signInContent: some View {
        ZStack {
            GlowBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 100)

                    // Logo
                    ZStack {
                        Circle()
                            .stroke(cyanColor.opacity(0.2), lineWidth: 1.5)
                            .frame(width: 80, height: 80)
                            .shadow(color: cyanColor.opacity(0.2), radius: 12)

                        Image(systemName: "sparkles")
                            .font(.system(size: 30, weight: .light))
                            .foregroundColor(cyanColor)
                            .shadow(color: cyanColor.opacity(0.4), radius: 8)
                    }

                    Spacer().frame(height: 30)

                    // Header
                    VStack(spacing: 8) {
                        Text("Welcome Back")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text("Sign in to continue")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Color.white.opacity(0.4))
                    }

                    Spacer().frame(height: 40)

                    // Form
                    VStack(spacing: 16) {
                        GlowTextField(placeholder: "Email", text: $email)
                        GlowTextField(placeholder: "Password", text: $password, isSecure: true)
                    }
                    .padding(.horizontal, 30)

                    // Forgot password
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(cyanColor.opacity(0.7))
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)

                    // Error
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color.red.opacity(0.8))
                            .padding(.top, 12)
                            .transition(.opacity)
                    }

                    Spacer().frame(height: 30)

                    // Sign In Button
                    GlowButton(title: "Sign In") {
                        handleSignIn()
                    }
                    .padding(.horizontal, 30)

                    Spacer().frame(height: 24)

                    // Switch to Sign Up
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showSignUp = true
                        }
                    }) {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundColor(Color.white.opacity(0.4))
                            Text("Sign Up")
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

    private func handleSignIn() {
        withAnimation(.easeInOut(duration: 0.2)) {
            errorMessage = ""
        }

        guard !email.isEmpty, !password.isEmpty else {
            withAnimation { errorMessage = "Please fill in all fields" }
            return
        }

        let success = authManager.signIn(email: email, password: password)
        if !success {
            withAnimation { errorMessage = "Invalid email or password" }
        }
    }
}
