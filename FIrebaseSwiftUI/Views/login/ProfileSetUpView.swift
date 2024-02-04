import SwiftUI

struct ProfileSetUpView: View {
    @State private var username: String = ""
    @State private var profilePictureURL: String = ""
    @EnvironmentObject var userviewModel: UserViewModel // ViewModelを環境オブジェクトとして使用

    var body: some View {
        Form {
            Section(header: Text("ユーザー情報")) {
                TextField("ユーザー名", text: $username)
                TextField("プロフィール画像URL", text: $profilePictureURL)
            }
            Button("登録") {
                userviewModel.registerUser(username: username, profilePictureURL: profilePictureURL)
            }
            .disabled(username.isEmpty)
        }
        .navigationTitle("プロフィール登録")
    }
}

