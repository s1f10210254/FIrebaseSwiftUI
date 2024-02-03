import SwiftUI
import FirebaseAuth
import FirebaseDatabase

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


    // プロフィールの完了状態を確認するメソッド
//        func checkUserProfileCompletion() {
//            guard let uid = Auth.auth().currentUser?.uid else {
//                self.profileCompleted = false
//                return
//            }
//
//            let ref = Database.database(url: "https://fir-swiftui-7c6f6-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child("users").child(uid)
//            ref.observeSingleEvent(of: .value, with: { snapshot in
//                if let value = snapshot.value as? [String: Any],
//                   let _ = value["profileCompleted"] as? Bool {
//                    // 仮に `profileCompleted` がユーザーデータに存在する場合
//                    self.profileCompleted = true
//                } else {
//                    self.profileCompleted = false
//                }
//            }) { error in
//                print(error.localizedDescription)
//                self.profileCompleted = false
//            }
//        }

}
