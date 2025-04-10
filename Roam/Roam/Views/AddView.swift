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
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var viewModel: LocationViewModel
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
                        Task {
                            if let placeName = await fetchNearbyPlace(location: location) {
                                let tempLocation = LocationData(id: UUID(), name: placeName, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, date: Date())
                                await addLocation(location: tempLocation)
                            }
                        }
                    }
                }
            } else {
                Text("Error Fetching location...")
            }
        }
    }
    
    private func fetchNearbyPlace(location: CLLocation) async -> String? {
        return await withCheckedContinuation { continuation in
            let circularLocationRestriction = GMSPlaceCircularLocationOption(
                CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude),
                30
            )
            let placeProperties = [GMSPlaceProperty.name].map { $0.rawValue }
            let request = GMSPlaceSearchNearbyRequest(
                locationRestriction: circularLocationRestriction,
                placeProperties: placeProperties
            )
            
            GMSPlacesClient.shared().searchNearby(with: request) { results, error in
                if let error = error {
                    print(error.localizedDescription)
                    continuation.resume(returning: nil)
                    return
                }
                DispatchQueue.main.async {
                    self.placeResults = results ?? []
                }
                continuation.resume(returning: results?.first?.name)
            }
        }
    }
}
