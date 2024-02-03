import SwiftUI
struct TabPageView: View{
    @Binding var selection:Int

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


        }
    }
}
