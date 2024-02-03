import SwiftUI
import Firebase

@main
struct FirebaseSwiftUIApp: App {
    @StateObject var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            // 認証状態に基づく条件分岐
            if authViewModel.isUserAuthenticated == .signedIn {
                    // プロフィールが完了している場合はMainViewを表示
                    MainView().environmentObject(authViewModel)
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

