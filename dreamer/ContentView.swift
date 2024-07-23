import SwiftUI

struct ContentView: View {
    
    @State private var the_dream = ""
    @State private var current_dream = ""
    @State private var apiResponse = ""
    
    // Instantiate NetworkManager
    private let networkManager = NetworkManager()
    
    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image("lucid_ream")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.tint)
                        .cornerRadius(50.0)
                    Spacer()
                    Text("Hello Dreamer")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .font(.title)
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                HStack {
                    TextField("Thought or Dream", text: $the_dream)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .foregroundColor(Color.indigo)
                        .frame(width: 250)
                        .fixedSize(horizontal: false, vertical: true)
                        .onSubmit {
                            handleDreamSubmission()
                        }
                    
                    Spacer()
                    
                    Image(systemName: "mic")
                        .imageScale(.large)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding(.all, 30)
                
                Spacer()
                // Display API response
                Text(apiResponse)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray.opacity(0.7))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                
                Spacer()
                VStack(spacing: 0) {
                    Divider()
                    
                    HStack {
                        Image(systemName: "house")
                            .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "book")
                            .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "person")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                }
                
            }
        }
    }
    
    // Handle dream submission and API call
    private func handleDreamSubmission() {
        current_dream = the_dream
        the_dream = ""
        
        // Call API
        let messages = [["role": "user", "content":
                            "You are professional Dream Therapist. Analyze the given dream below that is surrounded by the + symbol. If the prompt given doesn't seem like a dream then tell me it is not a dream.\n\n"
                         + "+" + current_dream + "+"]]
        networkManager.fetchChatCompletion(for: messages) { result in
            switch result {
            case .success(let response):
                if let content = response.choices.first?.message.content {
                    DispatchQueue.main.async {
                        apiResponse = content
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    apiResponse = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
