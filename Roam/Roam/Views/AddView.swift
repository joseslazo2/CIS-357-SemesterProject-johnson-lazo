//
//  AddView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//
import SwiftUI
import GooglePlaces

struct AddView: View {
    @Binding var goToAddView: Bool
    @Binding var goToMemoryView: Bool
    @Binding var goToHomeView: Bool
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var viewModel: LocationViewModel
    @State private var placeResults: [GMSPlace] = []
    var body: some View {
        VStack {
            if let location = locationManager.location {
                VStack {
                    HStack {
                        Button(action: {
                            goToHomeView = true
                            goToMemoryView = false
                            goToAddView = false
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
                    Spacer()
                    
                    Button("Save") {
                        // method 1
                        // https://developers.google.com/maps/documentation/places/ios-sdk/migrate-details
                        // A hotel in Saigon with an attribution.
//                        let placeID = "ChIJV4k8_9UodTERU5KXbkYpSYs"
//                        let client = GMSPlacesClient.shared()
//                        // Specify the place data types to return.
//                        let fields = [GMSPlaceProperty.name].map {$0.rawValue}
//
//                        // Create the GMSFetchPlaceRequest instance.
//                        let fetchPlaceRequest = GMSFetchPlaceRequest(placeID: placeID, placeProperties: fields, sessionToken: nil)
//
//                        client.fetchPlace(with: fetchPlaceRequest, callback: {
//                            (place: GMSPlace?, error: Error?) in
//                            guard let place, error == nil else { return }
//                            print("Place found: \(String(describing: place.name))")
//                            viewModel.saveLocation(name: place.name!, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, time: location.timestamp.formatted())
//                        })
                        
                        let circularLocationRestriction = GMSPlaceCircularLocationOption(
                             CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude),
                             10
                         )
                         let placeProperties = [GMSPlaceProperty.name].map { $0.rawValue }
                         var request = GMSPlaceSearchNearbyRequest(
                             locationRestriction: circularLocationRestriction,
                             placeProperties: placeProperties
                         )
                         
                         GMSPlacesClient.shared().searchNearby(with: request) { results, error in
                             if let error = error {
                                 print(error.localizedDescription)
                                 return
                             }
                             DispatchQueue.main.async {
                                 placeResults = results ?? []
                             }
                             for i in placeResults {
                                 print(i)
                             }
                             
                             // TODO - update time
                             viewModel.saveLocation(name: "josh's house", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, time: location.timestamp.formatted())
                         }
                    }
                }
            } else {
                Text("Error Fetching location...")
            }
        }
    }
}
