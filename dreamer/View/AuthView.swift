import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @Binding var isAuthenticated: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            Spacer()
            
            Text(isRegistering ? "Register" : "Sign In")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.bottom, 40)
            
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground).opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)
                .padding(.bottom, 20)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground).opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Button(action: isRegistering ? register : signIn) {
                Text(isRegistering ? "Register" : "Sign In")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom, 20)
            
            Button(action: {
                isRegistering.toggle()
            }) {
                Text(isRegistering ? "Already have an account? Sign In" : "Don't have an account? Register")
                    .foregroundColor(.white)
            }

            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
            
            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }

    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = ""
                isAuthenticated = true
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = ""
                isAuthenticated = true
            }
        }
    }
}

#Preview {
    AuthViewWrapper()
}

struct AuthViewWrapper: View {
    @State private var isAuthenticated = false

    var body: some View {
        AuthView(isAuthenticated: $isAuthenticated)
    }
}
