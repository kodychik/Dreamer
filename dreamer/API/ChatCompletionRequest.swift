import Foundation

struct ChatCompletionRequest: Codable {
    let model: String
    let messages: [[String: String]]
    let temperature: Double?
    let top_p: Double?
    let max_tokens: Int?
    let stream: Bool?
    let safe_prompt: Bool?
    let random_seed: Int?
}
