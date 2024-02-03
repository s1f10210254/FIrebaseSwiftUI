import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button("Sign In") {
                signInUser()
            }
            .padding()
        }
        .padding()
    }

    func signInUser() {
        authViewModel.signIn(email: email, password: password) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                // サインイン成功時の処理（例：メインビューへの遷移）
            }
        }
    }

}

