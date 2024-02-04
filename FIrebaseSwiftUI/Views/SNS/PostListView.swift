import SwiftUI
import Firebase

struct PostListView: View{
    @ObservedObject var viewModel = PostsViewModel()
    
    var body: some View{
//        List(viewModel.posts){ post in
//            VStack(alignment: .leading){
//                Text(post.content)
//                    .padding()
//                Text("Posted by \(post.userID)")
//                    .font(.footnote)
//                    .foregroundColor(.gray)
//            }
//            
//        }
        List(viewModel.posts) { post in
            VStack(alignment: .leading) {
                if let userProfilePictureURL = post.userProfilePictureURL, let url = URL(string: userProfilePictureURL) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

                Text(post.content)
                    .padding()

                if let username = post.username {
                    Text("Posted by \(username)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                } else {
                    Text("Posted by Unknown User")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }

        .onAppear(){
            self.viewModel.fetchPosts()
        }
    }
}
