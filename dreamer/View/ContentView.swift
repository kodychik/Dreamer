import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false

    var body: some View {
        if isAuthenticated {
            HomeView()
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
