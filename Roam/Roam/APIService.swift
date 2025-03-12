//
//  APIService.swift
//  Roam
//
//  Created by Joshua Johnson on 3/11/25.
//

import GooglePlaces

func fetchPlaceIDFromCurrentLocation(completion: @escaping (String?) -> Void) {
    let placesClient = GMSPlacesClient.shared()
    
    // Request place likelihoods (including the place ID)
    placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: [.placeID, .name]) { (likelihoods, error) in
        if let error = error {
            print("Error fetching places: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        // Check for the most likely place
        if let likelihoods = likelihoods, let topLikelihood = likelihoods.first {
            let placeID = topLikelihood.place.placeID
            print("Place ID: \(placeID ?? "Unknown Place ID")")
            completion(placeID)
        } else {
            print("No places found near the current location.")
            completion(nil)
        }
    }
}

