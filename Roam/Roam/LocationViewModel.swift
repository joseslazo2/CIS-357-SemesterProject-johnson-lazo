//
//  LocationViewModel.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//
import Foundation

class LocationViewModel: ObservableObject {
    @Published var locations: [LocationData] = []
    
    func saveLocation(name: String, latitude: Double, longitude: Double, time: String) {
        let locationData = LocationData(name: name, latitude: latitude, longitude: longitude, time: time)
        locations.append(locationData)
        
        if let encoded = try? JSONEncoder().encode(locations) {
            UserDefaults.standard.set(encoded, forKey: "SavedLocations")
        }
    }
}
