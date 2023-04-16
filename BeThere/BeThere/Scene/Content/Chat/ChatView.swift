import BaseKit
import SwiftUI

struct ChatView {
    private typealias Str = Txt.Chat
    @StateObject var viewModel: ChatViewModel
}

extension ChatView: View {
    var body: some View {
        VStack(spacing: .zero) {
            header
            Divider().styledDivider()
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
                    .padding(.top, .padding8)
                }
            }
            .withPlaceHolder(collection: viewModel.event.messages, text: Str.placeholderText)
            HStack(spacing: .padding16) {
                StyledField(style: .base, title: Str.messageLabel, text: $viewModel.currentMessage)
                IconButton(.send, action: viewModel.didTapSend)
            }
        }
        .eventNavigationBar(title: viewModel.event.name, editAction: viewModel.didTapEdit)
        .defaultViewSettings()
    }
}

extension ChatView {
    var header: some View {
        Card {
            VStack(spacing: .padding16) {
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
            }
        }
        .padding(.bottom, .padding16)
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatView(viewModel: .mock)
        }
    }
}
#endif
