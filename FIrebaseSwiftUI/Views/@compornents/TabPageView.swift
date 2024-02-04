import SwiftUI
struct TabPageView: View{
    @Binding var selection:Int
    @EnvironmentObject var userViewModel: UserViewModel // ユーザーモデルを環境オブジェクトとして使用

    var body: some View {
        TabView(selection: $selection){
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }.tag(1)
            SNSView()
                .tabItem {
                    Label("SNS", systemImage: "globe")
                }.tag(2)
            SystemView()
                .tabItem {
                    Label("System", systemImage: "gearshape")
                }.tag(3)
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle") // プロフィール用のラベルとアイコンを設定
                }.tag(4)
        }
        .environmentObject(userViewModel)
    }
}
