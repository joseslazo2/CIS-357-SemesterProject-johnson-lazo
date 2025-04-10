//
//  AddView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//
import SwiftUI
import GooglePlaces
import GooglePlacesSwift
//jimport FirebaseStorage

struct AddView: View {
    @Binding var goToAddView: Bool
    @Binding var goToMemoryView: Bool
    @Binding var goToHomeView: Bool
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var viewModel: LocationViewModel
    @State private var placeResults: [GMSPlace] = []
    @State private var currentPhoto: UIImage?
    
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
                    
                    if let photo = currentPhoto {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .padding()
                    }
                    
                    Spacer()
                    Button("Save") {
                        Task {
                            let (placeName, _) = await fetchNearbyPlace(location: location)
                            let tempLocation = LocationData(
                                id: UUID(), 
                                name: placeName, 
                                latitude: location.coordinate.latitude, 
                                longitude: location.coordinate.longitude, 
                                date: Date()
                            )
                            await addLocation(location: tempLocation)
                        }
                    }
                }
            } else {
                Text("Error Fetching location...")
            }
        }
    }
    
    private func fetchNearbyPlace(location: CLLocation) async -> (String?, String?) {
        return await withCheckedContinuation { continuation in
            let circularLocationRestriction = GMSPlaceCircularLocationOption(
                CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude),
                30
            )
            let placeProperties = [GMSPlaceProperty.name, GMSPlaceProperty.photos].map { $0.rawValue }
            let request = GMSPlaceSearchNearbyRequest(
                locationRestriction: circularLocationRestriction,
                placeProperties: placeProperties
            )
            
            GMSPlacesClient.shared().searchNearby(with: request) { results, error in
                if let error = error {
                    print(error.localizedDescription)
                    continuation.resume(returning: (nil, nil))
                    return
                }
                
                DispatchQueue.main.async {
                    self.placeResults = results ?? []
                }
                
                // Get the first photo metadata if available
                if let photoMetadata = results?.first?.photos?.first {
                    let fetchPhotoRequest = GMSFetchPhotoRequest(photoMetadata: photoMetadata, maxSize: CGSizeMake(4800, 4800))
                    GMSPlacesClient.shared().fetchPhoto(with: fetchPhotoRequest, callback: {
                        (photoImage: UIImage?, error: Error?) in
                          guard let photoImage, error == nil else {
                            print("Handle photo error: ")
                            return
                          }
                          DispatchQueue.main.async {
                              self.currentPhoto = photoImage
                          }
                        }
                    )
                    continuation.resume(returning: (results?.first?.name, nil))
                } else {
                    // No photos available
                    continuation.resume(returning: (results?.first?.name, nil))
                }
            }
        }
    }
}
