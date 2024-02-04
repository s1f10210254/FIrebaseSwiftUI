import Firebase
import SwiftUI
import FirebaseFirestoreSwift

class PostsViewModel: ObservableObject{
    @Published var posts = [Posts]()

//    func fetchPosts(){
//        Firestore.firestore().collection("posts").getDocuments(){ (querySnapshot, err) in
//            if let err = err{
//                print("Error getting documents: \(err)")
//            }else{
//                self.posts = querySnapshot!.documents.compactMap { document -> Posts? in
//                    try? document.data(as: Posts.self)
//                }
//            }
//        }
//    }

    func fetchPosts() {
        Firestore.firestore().collection("posts").getDocuments() { [weak self] (querySnapshot, err) in
            guard let self = self else { return }
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // 投稿データの一時格納用
                var postsWithUserInfo: [Posts] = []

                // 投稿データの取得
                let posts = querySnapshot!.documents.compactMap { document -> Posts? in
                    try? document.data(as: Posts.self)
                }

                // 各投稿に対するユーザー情報の取得
                let group = DispatchGroup()
                for post in posts {
                    group.enter()
                    let userId = post.userID
                    Firestore.firestore().collection("users").document(userId).getDocument { (userSnapshot, error) in
                        if let userSnapshot = userSnapshot, userSnapshot.exists,
                           let user = try? userSnapshot.data(as: User.self) {
                            // ユーザー情報を投稿データに追加
                            var postWithUser = post
                            postWithUser.username = user.username
                            postWithUser.userProfilePictureURL = user.profilePictureURL
                            postsWithUserInfo.append(postWithUser)
                        }
                        group.leave()
                    }
                }

                // 全てのユーザー情報の取得が完了したら、UIを更新
                group.notify(queue: .main) {
                    self.posts = postsWithUserInfo
                }
            }
        }
    }


    func addPost(content: String){
        let userID = Auth.auth().currentUser?.uid ?? "unknown"
        let post = Post(content: content, userID: userID, timestamp: Date())
        
        do{
            let _ = try Firestore.firestore().collection("posts").addDocument(from: post)
            fetchPosts()
        }catch{
            print(error.localizedDescription)
        }
    }
}


//struct Posts: Identifiable, Codable {
//    @DocumentID var id: String?
//    var content: String
//    var userID: String
//}
struct Posts: Identifiable, Codable {
    @DocumentID var id: String?
    var content: String
    var userID: String
    var username: String? // ユーザー名を追加
    var userProfilePictureURL: String? // ユーザープロフィール画像URLを追加
}


struct Post: Identifiable, Codable {
    var id: String = UUID().uuidString
    var content: String
    var userID: String
    var timestamp: Date
}
