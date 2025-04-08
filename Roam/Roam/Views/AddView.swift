//
//  AddView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//
import SwiftUI
import GooglePlaces
import GooglePlacesSwift
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
//                        let placesClient = GMSPlacesClient.shared()
//                        let placeFields: GMSPlaceField = [.name]
//                        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { (placeLikelihoods, error) in
//                            if let error = error {
//                                print("Error fetching place likelihoods: \(error.localizedDescription)")
//                                return
//                            }
//
//                            if let likelihoods = placeLikelihoods {
//                                for likelihood in likelihoods {
//                                    let place = likelihood.place
//                                    let confidence = likelihood.likelihood
//                                    print("Place: \(place.name ?? "Unnamed")")
//                                    print("Confidence: \(confidence)")
//                                }
//                            }
//                        }

                        
                        
                        
                        
                        
                        // method 2
                        let circularLocationRestriction = GMSPlaceCircularLocationOption(
                             CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude),
                             2500
                         )
                        let placeProperties = [GMSPlaceProperty.name].map { $0.rawValue }
                        let request = GMSPlaceSearchNearbyRequest(
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
                                 print(i.name!)
                             }
                             viewModel.saveLocation(name: placeResults.first?.name ?? "error unwrapping", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, time: location.timestamp.formatted())
                         }
                       
                    }
                }
            } else {
                Text("Error Fetching location...")
            }
        }
    }
}
