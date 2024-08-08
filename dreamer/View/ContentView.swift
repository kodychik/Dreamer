import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false

    var body: some View {
        if isAuthenticated {
            //HomeView()
            TabView {
                HomeView().tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                        .foregroundColor(.white)
                }
                DreamList().tabItem() {
                    Image(systemName: "book")
                    Text("Home")
                        .foregroundColor(.white)
                }
            }
            
        } else {
            AuthView(isAuthenticated: $isAuthenticated)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
