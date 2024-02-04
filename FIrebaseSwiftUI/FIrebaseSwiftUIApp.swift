import SwiftUI
import Firebase

@main
struct FirebaseSwiftUIApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var userViewModel = UserViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            // 認証状態に基づく条件分岐
            if authViewModel.isUserAuthenticated == .signedIn {
                // プロフィールが完了している場合はMainViewを表示
                if authViewModel.profileCompleted  {
                    MainView().environmentObject(authViewModel)
                }else{
                    ProfileSetUpView().environmentObject(userViewModel)
                }
            } else if authViewModel.isUserAuthenticated == .signedOut {
                // ユーザーがサインアウトしている場合はHelloViewを表示
                HelloView().environmentObject(authViewModel)
            } else {
                // 認証状態が未定義の場合はLoadingViewを表示
                LoadingView().environmentObject(authViewModel)
            }
        }
    }
}

