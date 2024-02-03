import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject{
  @Published var isUserAuthenticated: AuthStatus = .undefined
  
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
}
