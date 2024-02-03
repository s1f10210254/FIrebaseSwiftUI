import SwiftUI
import Firebase

@main
struct FIrebaseSwiftUIApp: App {
    @StateObject var authViewModel = AuthViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
