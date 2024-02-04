import Firebase
import FirebaseFirestore

class UserViewModel: ObservableObject{
    var authViewModel: AuthViewModel?
    @Published var currentUser: User?
    
    func registerUser(username: String, profilePictureURL: String){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let user = User(id: userID, username: username, profilePictureURL: profilePictureURL.isEmpty ? nil : profilePictureURL)
        
        do {
            try Firestore.firestore().collection("users").document(userID).setData(from: user)
            DispatchQueue.main.async{
                self.authViewModel?.profileCompleted = true
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchCurrentUserProfile(){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let userRef = Firestore.firestore().collection("users").document(userID)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists{
                do {
                    let user = try document.data(as: User.self)
                    DispatchQueue.main.async {
                        self.currentUser = user // 取得したユーザー情報をcurrentUserに格納
                    }
                }catch{
                    print("Error decoding user: \(error)")
                }
            }else{
                print("User document does not exist")
            }
        }
    }
}
