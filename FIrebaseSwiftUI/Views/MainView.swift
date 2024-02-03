import SwiftUI

struct MainView: View {
//    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selection = 1 

    var body: some View {
        TopBarView(selection: selection)
        TabPageView(selection: $selection)
    }
}

struct MainView_Previws: PreviewProvider{
    static var previews: some View{
        VStack{
            MainView()
        }
    }
}
