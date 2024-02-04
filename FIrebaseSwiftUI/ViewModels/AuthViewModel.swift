import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject{
    @Published var isUserAuthenticated: AuthStatus = .undefined
    @Published var profileCompleted = false

    enum AuthStatus{
        case undefined, signedOut, signedIn
    }

    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    init(){
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener{ _, user in
            if let user = user {
                self.isUserAuthenticated = .signedIn
                // プロフィールの完了状態を確認
                self.checkUserProfileCompletion(userId: user.uid)
            }else{
                self.isUserAuthenticated = .signedOut
                self.profileCompleted = false
            }
        }
    }

    func checkUserProfileCompletion(userId: String){
        Firestore.firestore().collection("users").document(userId).getDocument { document, error in
            if let document = document, document.exists{
                self.profileCompleted = true
            } else{
                self.profileCompleted  = false
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
