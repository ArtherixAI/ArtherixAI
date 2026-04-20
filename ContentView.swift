import SwiftUI

struct ContentView: View {
    @StateObject var vm = ChatViewModel()

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(vm.messages, id: \.self) { msg in
                        Text(msg)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }

            HStack {
                TextField("Message...", text: $vm.input)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    vm.sendMessage()
                }
            }
            .padding()
        }
        .padding()
    }
}
