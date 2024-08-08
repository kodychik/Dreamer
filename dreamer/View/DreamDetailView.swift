import SwiftUI

struct DreamDetailView: View {
    var dreamTitle: String
    var dreamDescription: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(dreamTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(dreamDescription)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Dream Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
