import Firebase
import SwiftUI
import FirebaseFirestoreSwift

class PostsViewModel: ObservableObject{
    @Published var posts = [Posts]()

    func fetchPosts(){
        Firestore.firestore().collection("posts").getDocuments(){ (querySnapshot, err) in
            if let err = err{
                print("Error getting documents: \(err)")
            }else{
                self.posts = querySnapshot!.documents.compactMap { document -> Posts? in
                    try? document.data(as: Posts.self)
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


struct Posts: Identifiable, Codable {
    @DocumentID var id: String?
    var content: String
    var userID: String
}

struct Post: Identifiable, Codable {
    var id: String = UUID().uuidString
    var content: String
    var userID: String
    var timestamp: Date
}
