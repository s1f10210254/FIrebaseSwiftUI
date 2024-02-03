import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Loading...")
                .scaleEffect(2.0)
        }
    }
}

