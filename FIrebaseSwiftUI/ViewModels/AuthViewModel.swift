import SwiftUI
import FirebaseAuth
//import FirebaseDatabase

class AuthViewModel: ObservableObject{
    @Published var isUserAuthenticated: AuthStatus = .undefined
    @Published var profileCompleted = false

    enum AuthStatus{
        case undefined, signedOut, signedIn
    }

    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    init(){
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener{ _, user in
            if let _ =  user {
                self.isUserAuthenticated = .signedIn
            }else{
                self.isUserAuthenticated = .signedOut
            }
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                return
            }
            self.isUserAuthenticated = .signedIn
            completion(nil)
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                return
            }
            self.isUserAuthenticated = .signedIn
            completion(nil)
        }
    }

    func signOut(){
        do{
            try Auth.auth().signOut()
            self.isUserAuthenticated = .signedOut
        }catch let signOutError{
            print("ログアウトエラー:\(signOutError)")
        }
    }

}
