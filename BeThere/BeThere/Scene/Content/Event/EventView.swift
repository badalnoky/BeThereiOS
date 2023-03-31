import BaseKit
import SwiftUI

struct EventView {
    private typealias Str = Txt.EventScreen
    @StateObject var viewModel: EventViewModel
}

extension EventView: View {
    var body: some View {
        VStack {
            HStack {
                Text(Str.nameLabel)
                TextField(String.empty, text: $viewModel.name)
            }
            HStack {
                Text(Str.dateLabel)
                Spacer()
                Button {
                    viewModel.isChoosingDate = true
                } label: {
                    Text(viewModel.date, format: .dateTime.month().day().hour().minute())
                }
            }
            HStack {
                Text(Str.locationLabel)
                TextField(String.empty, text: $viewModel.location)
            }
            HStack {
                Text(Str.membersLabel)
                Spacer()
                IconButton(.addFriends, action: viewModel.didTapAddFriends)
            }
            ScrollView {
                ForEach(viewModel.members.indices, id: \.self) { idx in
                    let member = viewModel.members[idx]
                    Text(member.name)
                }
            }
            Button(Str.saveLabel, action: viewModel.didTapSave)
        }
        .sheet(isPresented: $viewModel.isChoosingDate) {
            DatePicker(String.empty, selection: $viewModel.date, in: Date.now...)
                .datePickerStyle(.graphical)
                .presentationDetents([.medium])
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
