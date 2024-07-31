import Foundation

class HomeViewModel: ObservableObject {
    @Published var theDream = ""
    @Published var currentDream = ""
    @Published var apiResponse = ""

    private let networkManager = NetworkManager()

    func handleDreamSubmission() {
        currentDream = theDream
        theDream = ""
        callAPI(with: currentDream)
    }

    private func callAPI(with dream: String) {
        let messages = [
            ["role": "user", "content": "You are a professional Dream Therapist. Analyze the given dream below that is surrounded by the + symbol. If the prompt given doesn't seem like a dream then explain why it doesn't seem like a dream. Limit your response to 100 words.\n\n+\(dream)+"]
            ]

        networkManager.fetchChatCompletion(for: messages) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.apiResponse = response.choices.first?.message.content ?? "No response"
                case .failure(let error):
                    self?.apiResponse = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
