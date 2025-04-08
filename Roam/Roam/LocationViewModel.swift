//
//  LocationViewModel.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//
import Foundation

class LocationViewModel: ObservableObject {
    @Published var locations: [LocationData] = []
}
