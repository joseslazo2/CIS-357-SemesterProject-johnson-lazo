//
//  APIService.swift
//  Roam
//
//  Created by Joshua Johnson on 3/11/25.
//

import GooglePlaces

class APIService {
    private let placesClient = GMSPlacesClient.shared()
    
    func getCurrentPlaceName(completion: @escaping (String?, Error?) -> Void) {
        print("APIService ran")
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: .name) { (likelihoods, error) in
            if let error = error {
                // Handle error
                print("err")
                completion(nil, error)
                return
            }
            
            // Check for the first likelihood (most likely place)
            if let likelihoods = likelihoods, let topLikelihood = likelihoods.first {
                let placeName = topLikelihood.place.name
                completion(placeName, nil)
            } else {
                // Handle no results
                completion(nil, NSError(domain: "APIService", code: 404, userInfo: [NSLocalizedDescriptionKey: "No places found"]))
            }
        }
    }
}
