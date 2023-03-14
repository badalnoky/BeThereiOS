import SwiftUI

struct ChatView {
    private typealias Str = Txt.Chat
    @StateObject var viewModel: ChatViewModel
}

extension ChatView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                IconButton(.edit, action: viewModel.didTapEdit)
            }
            HStack {
                Text(Str.dateLabel)
                Spacer()
                Text(viewModel.date, format: .dateTime.month().day().hour().minute())
            }
            HStack {
                Text(Str.locationLabel)
                Spacer()
                Text(viewModel.location)
            }
            Divider()
            ScrollView {
                ForEach(viewModel.messages, id: \.self) { message in
                    Text(message)
                }
            }
            HStack {
                TextField(text: $viewModel.currentMessage) {
                    Text(String.empty)
                }
                Image.send
            }
        }
        .navigationTitle(viewModel.event)
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: .mock)
    }
}
#endif
