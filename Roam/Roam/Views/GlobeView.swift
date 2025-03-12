//
//  GlobeView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//

import SwiftUI


struct GlobeView: View {
    @Binding var goToMemoryView: Bool
    @Binding var goToGlobeView: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                Button(action: {
                    goToMemoryView = true
                    goToGlobeView = false
                }){
                    Image(systemName: "arrowshape.turn.up.backward")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.blue)
                    
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 15))
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
}
