import BaseKit
import SwiftUI

public struct ChatItem: View {
    let message: Message
    let settings: MessageSettings
    let urlString: String?

    public var body: some View {
        HStack(spacing: .padding16) {
            if let url = urlString, !settings.sentByUser, !settings.isContinued {
                CachedAsyncImage(urlString: url, color: .appPrimary, size: .smallImageSize)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, .padding16)
            } else {
                Spacer().frame(width: .smallIconSize)
            }
            Text(message.text)
                .messageSettings(settings)
        }
    }

    public init(message: Message, settings: MessageSettings, urlString: String?) {
        self.message = message
        self.settings = settings
        self.urlString = urlString
    }
}

#if DEBUG
struct ChatItem_Previews: PreviewProvider {
    static var previews: some View {
        ChatItem(
            message: Message(id: .empty, sentBy: .empty, text: .empty),
            settings: MessageSettings(sentByUser: false, isContinued: false),
            urlString: .empty
        )
    }
}
#endif
