import SwiftUI

struct CreatePostView: View {
    @State private var content = ""
    var viewModel: PostsViewModel
    var body: some View {
        VStack{
            TextField("ここに内容を入力してください", text: $content)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .padding()
            Button("投稿"){
                viewModel.addPost(content: content)
                self.content = ""
            }
            .disabled(content.isEmpty)
        }
        .padding()
    }


}


