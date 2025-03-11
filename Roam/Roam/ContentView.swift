//
//  ContentView.swift
//  Roam
//
//  Created by Joshua Johnson on 2/27/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject var viewModel = LocationViewModel()
    @State private var goToHomeView = true
    @State private var goToMemoryView = false
    @State private var goToAddView = false
    @State private var goToGlobeView = false
    var body: some View {
        VStack {
            if goToHomeView {
                HomeView(goToAddView: $goToAddView, goToMemoryView: $goToMemoryView, goToHomeView: $goToHomeView)
            } else if goToAddView {
                AddView(goToAddView: $goToAddView, goToMemoryView: $goToMemoryView, goToHomeView: $goToHomeView, locationManager: locationManager, viewModel: viewModel)
            } else if goToMemoryView {
                MemoryView(goToAddView: $goToAddView, goToMemoryView: $goToMemoryView, goToHomeView: $goToHomeView, goToGlobeView: $goToGlobeView, viewModel: viewModel)
            } else if goToGlobeView {
                GlobeView(goToMemoryView: $goToMemoryView, goToGlobeView: $goToGlobeView)
            }
        }
    }
}
