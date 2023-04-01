import BaseKit
import SwiftUI

struct ChatView {
    private typealias Str = Txt.Chat
    @StateObject var viewModel: ChatViewModel
}

extension ChatView: View {
    var body: some View {
        VStack {
            Text(viewModel.event.name)
            HStack {
                Spacer()
                IconButton(.edit, action: viewModel.didTapEdit)
            }
            HStack {
                Text(Str.dateLabel)
                Spacer()
                Text(viewModel.event.date, format: .dateTime.month().day().hour().minute())
            }
            HStack {
                Text(Str.locationLabel)
                Spacer()
                Text(viewModel.event.location)
            }
            Divider()
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: .zero) {
                        ForEach(viewModel.event.messages.indices, id: \.self) { idx in
                            let message = viewModel.event.messages[idx]
                            let settings = viewModel.getMessageSettings(indexed: idx)
                            ChatItem(message: message, settings: settings, urlString: viewModel.urlCatalog[message.sentBy])
                            .onAppear { proxy.scrollTo(viewModel.event.messages.indices.last) }
                            .id(idx)
                        }
                    }
                }
            }
            HStack {
                TextField(text: $viewModel.currentMessage) {
                    Text(String.empty)
                }
                IconButton(.send, action: viewModel.didTapSend)
            }
        }
        .navigationTitle(viewModel.event.name)
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: .mock)
    }
}
#endif
