import SwiftUI
import Firebase

struct PostListView: View{
    @ObservedObject var viewModel = PostsViewModel()
    
    var body: some View{
        List(viewModel.posts){ post in
            VStack(alignment: .leading){
                Text(post.content)
                    .padding()
                Text("Posted by \(post.userID)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
        }
        .onAppear(){
            self.viewModel.fetchPosts()
        }
    }
}
