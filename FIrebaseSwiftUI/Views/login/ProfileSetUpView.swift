import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct ProfileSetUpView: View{
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var displayName = ""
    @State private var userId = ""
    @State private var errorMessage: String?

    var body: some View{
    
        VStack {
            TextField("Display Name", text: $displayName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("User ID", text: $userId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button("Save Profile") {
                saveProfile()
            }
            .padding()
        }
        .padding()
//        .onAppear{
//            authViewModel.checkUserProfileCompletion()
//        }
    }

    func saveProfile() {
        // ユーザーIDのユニーク性をチェック
        checkUserIdUniqueness(userId: userId) { isUnique in
            print("check true")
            if isUnique {
                print("isUnique true")
                // ユーザーIDがユニークならプロフィールを保存
                self.updateUserProfile(displayName: self.displayName, userId: self.userId)
            } else {
                print("isUnique false")
                // ユニークでない場合はエラーメッセージを表示
                self.errorMessage = "This user ID is already taken. Please choose another one."
            }
        }
    }

    func checkUserIdUniqueness(userId: String, completion: @escaping (Bool) -> Void) {
        let ref = Database.database(url: "https://fir-swiftui-7c6f6-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child("users").queryOrdered(byChild: "userId").queryEqual(toValue: userId)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                // userIdが既に存在する場合
                completion(false)
            } else {
                // userIdがユニークな場合
                completion(true)
            }
        })
    }

    func updateUserProfile(displayName: String, userId: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        // Realtime Databaseにユーザープロフィールを保存
        let ref = Database.database(url: "https://fir-swiftui-7c6f6-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child("users").child(currentUser.uid)
        ref.setValue(["displayName": displayName, "userId": userId]) { error, _ in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                // プロフィールの保存に成功した後の処理
                print("プロフィール成功")
                
            }
        }
    }


}
