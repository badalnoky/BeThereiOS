import SwiftUI

struct ChatView: View {
    var body: some View {
        Text("Chat")
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
#endif
