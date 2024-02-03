import SwiftUI

struct SNSView: View {
    @StateObject var postViewModel = PostsViewModel()

    var body: some View {
        VStack{
            CreatePostView(viewModel: postViewModel)
            PostListView(viewModel: postViewModel)
        }

    }
}

