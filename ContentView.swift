import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var messages: [String] = ["ArtherixAI: Hello 👋"]

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages, id: \.self) { msg in
                        Text(msg)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }

            HStack {
                TextField("Message...", text: $text)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    messages.append("You: \(text)")
                    messages.append("AI: \(text)")
                    text = ""
                }
            }
            .padding()
        }
        .padding()
    }
}
