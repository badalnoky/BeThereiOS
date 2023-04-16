import BaseKit
import SwiftUI

struct EventView {
    private typealias Str = Txt.EventScreen
    @StateObject var viewModel: EventViewModel
}

extension EventView: View {
    var body: some View {
        VStack {
            StyledField(style: .base, title: Str.nameLabel, text: $viewModel.name)
            StyledField(style: .base, title: Str.locationLabel, text: $viewModel.location)
            Card {
                HStack {
                    Text(Str.dateLabel)
                    Spacer()
                    Button(action: viewModel.setChoosingDate) {
                        Text(viewModel.date, format: .dateTime.month().day().hour().minute())
                    }
                }
            }
            HStack {
                Text(Str.membersLabel).textStyle(.callout)
                Spacer()
                IconButton(.addFriends, action: viewModel.didTapAddFriends)
            }
            ScrollView {
                ForEach(viewModel.members.indices, id: \.self) { idx in
                    let member = viewModel.members[idx]
                    Card {
                        Text(member.name).frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            Button(Str.saveLabel, action: viewModel.didTapSave)
                .buttonStyle(BaseButtonStyle())
        }
        .defaultNavigationBar(title: Str.title)
        .defaultViewSettings()
        .sheet(isPresented: $viewModel.isChoosingDate) {
            DatePicker(String.empty, selection: $viewModel.date, in: Date.now...)
                .datePickerStyle(.graphical)
                .presentationDetents([.medium])
        }
        .alert(viewModel.alertText, isPresented: $viewModel.displayAlert) {
            Button(Str.dismissButton, role: .cancel) { }
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
