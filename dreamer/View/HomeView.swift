import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore



struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    //private let dreamRepository = DreamRepository() // Create an instance of DreamRepository
    // Example dream object
    @State private var error_msg = "Reveal your mind"
    private var userID = Auth.auth().currentUser!.uid
    @State private var title = ""
    @State private var content = ""
    @State private var psychoanalysis = ""
    @State private var date = Date()
    @State private var showAlert = false

    //@State private var dream = Dream(userID: "", title: "", content: "", psychoanalysis: "", date: Date())
    
    // initialize dream

    var body: some View {
        ZStack {
            Color.indigo.ignoresSafeArea()

            VStack {
                headerView
                Spacer()
                dreamInputView
                Spacer()
                responseView
                //Spacer()
                //footerView
            }
        }
    }

    private var headerView: some View {
        HStack {
            Image("lucid_ream")
                .resizable()
                .frame(width: 70, height: 70)
                .cornerRadius(50.0)
            Spacer()
            Text("Hello Dreamer")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title)
            Spacer()
        }
        .padding(.horizontal, 30)
    }

    private var dreamInputView: some View {
        HStack {
            TextField("Thought or Dream", text: $viewModel.theDream)
                .textFieldStyle(.plain)
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                .foregroundColor(Color.indigo)
                .frame(width: 250)
                .fixedSize(horizontal: false, vertical: true)
                .onSubmit {
                    viewModel.handleDreamSubmission()
                }
            Spacer()
            Image(systemName: "mic")
                .imageScale(.large)
                .foregroundColor(.white)
            Spacer()
//            Button(action: signIn) {
//                Text("Sign In")
//            }
            Button(action: {
                Task {
                    showAlert = true
                    
                }
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
            }
            
        }
        .padding(.all, 30)
    }
    
    private var popupOverlay: some View {
        VStack(spacing: 20) {
            Text("Enter Dream Title")
                .font(.headline)
            
            titleField
            
            HStack {
                Button("Cancel") {
                    showAlert = false
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Save") {
                    Task {
                        if !title.isEmpty {
                            await addDream()
                            showAlert = false
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 2)
        )
        .padding()
    }
    
    private var titleField: some View {
        TextField("Enter Title", text: $title)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }

    private var responseView: some View {
        VStack{
            Spacer()
            if showAlert {
                popupOverlay
            }
            Spacer()
            Text(error_msg).foregroundColor(.white)
            Spacer()
            Text(viewModel.apiResponse)
                .foregroundColor(.white)
                .padding()
                .background(Color.gray.opacity(0.7))
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .padding()
            Spacer()
        }
    }

    private var footerView: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                Image(systemName: "house")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "book")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "person")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
        }
    }
    
    
    private func addDream() async {
        
        
        
        content = viewModel.currentDream
        psychoanalysis = viewModel.apiResponse
        
        let db = Firestore.firestore()
        print("************************")
        do {
            print("************************")
            try await db.collection(userID).document(title).setData([
                "Dream": content,
                "Analysis": psychoanalysis,
                "Date": date
            ])
            print("Document successfully written!")
            error_msg = "Dream Saved!"
                
        } catch {
            print("Error writing document")
            error_msg = "Error writing document"
        }
    }

}




#Preview {
    HomeView()
}
