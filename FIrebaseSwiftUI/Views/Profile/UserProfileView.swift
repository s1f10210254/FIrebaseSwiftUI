import SwiftUI

struct UserProfileView: View{
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View{
        VStack{
            if let profilePictureURL = userViewModel.currentUser?.profilePictureURL, let url = URL(string: profilePictureURL){
                AsyncImage(url:url){ image in
                    image.resizable()
                }placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding()
            }else{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
            }
            if let username = userViewModel.currentUser?.username{
                Text(username).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
        }
        .onAppear{
            userViewModel.fetchCurrentUserProfile()
        }
    }
}
