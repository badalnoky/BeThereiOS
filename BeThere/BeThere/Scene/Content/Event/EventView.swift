import SwiftUI

struct EventView {
    private typealias Str = Txt.Event
    @StateObject var viewModel: EventViewModel
}

extension EventView: View {
    var body: some View {
        VStack {
            HStack {
                Text(Str.nameLabel)
                Spacer()
                Text(viewModel.event)
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
            HStack {
                Text(Str.membersLabel)
                Spacer()
                Image.addFriends
            }
            ScrollView {
                ForEach(viewModel.members, id: \.self) { member in
                    Text(member)
                }
            }
            Button(Str.saveLabel) {}
        }
    }
}

#if DEBUG
struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(viewModel: .mock)
    }
}
#endif
