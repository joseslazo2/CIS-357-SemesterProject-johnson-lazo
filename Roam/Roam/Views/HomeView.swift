//
//  HomeView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var goToAddView: Bool
    @Binding var goToMemoryView: Bool
    @Binding var goToHomeView: Bool
    
    var body: some View {
        Spacer()
        
        // ---------- NAVIGATION BAR ----------
        HStack {
            Button(action: {
                goToHomeView = true
                goToAddView = false
                goToMemoryView = false
            }) {
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.white)
            }
            
            
            Spacer()
            
            
            Button(action: {
                goToAddView = true
                goToMemoryView = false
                goToHomeView = false
            }){
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.white)
            }
            Spacer()
            
            Button(action:{
                goToMemoryView = true
                goToHomeView = false
                goToAddView = false
            }){
                Image(systemName: "clock.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color.white)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 45)
        .background(Color.gray)
    }
}
