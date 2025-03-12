//
//  MemoryView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//

import SwiftUI

struct MemoryView: View {
    @Binding var goToAddView: Bool
    @Binding var goToMemoryView: Bool
    @Binding var goToHomeView: Bool
    @Binding var goToGlobeView: Bool
    @ObservedObject var viewModel: LocationViewModel
    var body: some View {
        // top right is a globe icon
        // when pressed you go into globe view and see all the locations you've saved
        
        // card view most recent - oldest
        // potentially have a sorting drop down
        // nearest - furthest
        // most unique (furthest away from all other entries or if starred)
        
        // TODO - figure out how to add items to the screen
        // best way to store items so to not leak memory
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    goToGlobeView = true
                    goToAddView = false
                    goToMemoryView = false
                    goToHomeView = false
                }){
                    Image(systemName: "globe.americas")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding()
            Spacer()
            List(viewModel.locations) { locationData in
                VStack(alignment: .leading) {
                    Text(locationData.name)
                        .font(.headline)
                    Text("Lat: \(locationData.latitude), Long: \(locationData.longitude)")
                    Text("Date: \(locationData.time)")
                        .font(.subheadline)
                }
            }
            Spacer()
            
            // ---------- NAVIGATION BAR ----------
            HStack {
                Button(action: {
                    goToHomeView = true
                    goToAddView = false
                    goToMemoryView = false
                    goToGlobeView = false
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
                    goToGlobeView = false
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
                    goToGlobeView = false
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
}
