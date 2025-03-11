//
//  LocationData.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//
import Foundation

struct LocationData: Identifiable, Codable {
    var id = UUID()
    var name: String // this has to come from google places api but itll be added manually for now
    var latitude: Double
    var longitude: Double
    var time: String
    // want to add photo but not sure if thats possible yet
}
