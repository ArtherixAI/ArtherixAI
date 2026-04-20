import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = ["ArtherixAI: Ready 🤖"]
    @Published var input: String = ""

    let api = APIService()

    func sendMessage() {
        let text = input
        guard !text.isEmpty else { return }

        messages.append("You: \(text)")
        input = ""

        Task {
            let response = await api.sendToAI(message: text)
            DispatchQueue.main.async {
                self.messages.append("AI: \(response)")
            }
        }
    }
}
