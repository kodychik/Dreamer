//
//  dreamList.swift
//  dreamer
//
//  Created by Kody Chik on 2024-08-07.
//

import Foundation
import SwiftUI
import FirebaseFirestore


struct DreamList: View {
    @StateObject private var listView = DreamListModel()
    
    var body: some View {
        
        ZStack {
            Color.indigo.ignoresSafeArea()
            VStack {
                headerView
                the_list
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
            Text("Here is your collection")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title)
            Spacer()
        }
        .padding(.horizontal, 30)
    }
    
    private var the_list: some View {
        List (listView.usersDreams){ dream in
            VStack(alignment: .leading) {
                Text(dream.title).font(.title)
                Text(dream.date).font(.subheadline)
            }
        }
        .onAppear() {
            listView.get_dreams()
        }
    }
    
    

}

#Preview {
    DreamList()
}
