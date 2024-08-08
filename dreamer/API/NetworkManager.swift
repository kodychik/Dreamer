import Foundation

class NetworkManager {
    private let apiKey = ""
    private let apiURL = "https://api.mistral.ai/v1/chat/completions"

    func fetchChatCompletion(for messages: [[String: String]], completion: @escaping (Result<ChatCompletionResponse, Error>) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        print("**************")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ChatCompletionRequest(
            model: "open-mistral-7b",
            messages: messages,
            temperature: 0.7,
            top_p: 1,
            max_tokens: 200,
            stream: false,
            safe_prompt: false,
            random_seed: 1337
        )
        print("**************")

        request.httpBody = try? JSONEncoder().encode(body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            print(data)

            do {
//                print("((((((((((((((")
//                let responseObject = try JSONDecoder().decode(ChatCompletionResponse.self, from: data)
//                completion(.success(responseObject))
//                print("((((((((((((((")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON response: \(jsonString)")
                }
                let responseObject = try JSONDecoder().decode(ChatCompletionResponse.self, from: data)
                completion(.success(responseObject))
            } catch {
                print("%%%%%%%%%%%%%%%%%%")
                completion(.failure(error))
                print(error)
                
            }
        }
        print("**************")

        task.resume()
    }

    enum NetworkError: Error {
        case invalidURL
        case noData
    }
}
