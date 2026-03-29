import SwiftUI

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var hasSeenWelcome: Bool
    @Published var currentUsername: String = ""

    private let welcomeKey = "hasSeenWelcome"
    private let accountsKey = "savedAccounts"
    private let usernameKey = "currentUsername"

    init() {
        self.hasSeenWelcome = UserDefaults.standard.bool(forKey: welcomeKey)
        if let name = UserDefaults.standard.string(forKey: usernameKey), !name.isEmpty {
            self.currentUsername = name
            self.isLoggedIn = true
        }
    }

    func markWelcomeSeen() {
        hasSeenWelcome = true
        UserDefaults.standard.set(true, forKey: welcomeKey)
    }

    func signUp(username: String, email: String, password: String) -> Bool {
        var accounts = getAccounts()
        if accounts[email] != nil {
            return false
        }
        accounts[email] = ["username": username, "password": password]
        saveAccounts(accounts)
        currentUsername = username
        UserDefaults.standard.set(username, forKey: usernameKey)
        isLoggedIn = true
        return true
    }

    func signIn(email: String, password: String) -> Bool {
        let accounts = getAccounts()
        if let account = accounts[email],
           account["password"] == password {
            currentUsername = account["username"] ?? "User"
            UserDefaults.standard.set(currentUsername, forKey: usernameKey)
            isLoggedIn = true
            return true
        }
        return false
    }

    func signOut() {
        isLoggedIn = false
        currentUsername = ""
        UserDefaults.standard.removeObject(forKey: usernameKey)
    }

    private func getAccounts() -> [String: [String: String]] {
        if let data = UserDefaults.standard.data(forKey: accountsKey),
           let accounts = try? JSONDecoder().decode([String: [String: String]].self, from: data) {
            return accounts
        }
        return [:]
    }

    private func saveAccounts(_ accounts: [String: [String: String]]) {
        if let data = try? JSONEncoder().encode(accounts) {
            UserDefaults.standard.set(data, forKey: accountsKey)
        }
    }
}
