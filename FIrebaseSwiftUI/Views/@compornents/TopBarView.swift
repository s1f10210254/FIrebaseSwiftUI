import SwiftUI

struct TopBarView: View {
    @State private var shoingAlert = false
    @EnvironmentObject var authViewModel: AuthViewModel
    var selection: Int
    var body: some View {
        HStack{
            Button("ログアウト"){
                self.shoingAlert = true
            }
            .padding(.leading, 30)
            .alert(isPresented: $shoingAlert){
                Alert(title: Text("タイトル"),
                      message: Text("ログアウトしますか？"),
                      primaryButton: .cancel(Text("キャンセル")),
                      secondaryButton: .default(Text("了解"), action: authViewModel.signOut)
                )
            }
            Spacer()
            if selection == 1{
                Label("AR", systemImage: "camera")
            }
            Spacer()
        }
    }
}
