import SwiftUI

struct UserProfileEditView: View{
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var username: String = ""
    @State private var profilePictureURL: String = ""

    var body: some View{
        Form{
            Section(header: Text("ユーザー情報")) {
                TextField("ユーザー名", text: $username)
                TextField("プロフィール画像URL", text: $profilePictureURL)
            }
            Button("保存"){
                userViewModel.updateUserProfile(username: username, profilePictureURL: profilePictureURL)
            }
        }
        .navigationTitle("プロフィール編集")
        .onAppear {
            // 初期値を現在のユーザー情報で設定
            username = userViewModel.currentUser?.username ?? ""
            profilePictureURL = userViewModel.currentUser?.profilePictureURL ?? ""
        }
    }
}
