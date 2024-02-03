import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        Spacer()
        Text("MainView").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        Spacer()
        Button("ログアウト"){
            authViewModel.signOut()
        }
    }
}

struct MainView_Previws: PreviewProvider{
    static var previews: some View{
        VStack{
            MainView()
        }
    }
}
