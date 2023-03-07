import SwiftUI

struct EventView: View {
    var body: some View {
        Text("Event")
    }
}

#if DEBUG
struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
#endif
