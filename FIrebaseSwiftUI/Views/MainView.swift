import SwiftUI

struct MainView: View {
    @StateObject var userViewModel = UserViewModel()
    @State private var selection = 1

    var body: some View {
        TopBarView(selection: selection)
        TabPageView(selection: $selection)
            .environmentObject(userViewModel)
    }
}

struct MainView_Previws: PreviewProvider{
    static var previews: some View{
        VStack{
            MainView()
        }
    }
}
