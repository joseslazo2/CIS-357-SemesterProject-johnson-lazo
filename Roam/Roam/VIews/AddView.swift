//
//  AddView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//
import SwiftUI


struct AddView: View {
    @Binding var goToAddView: Bool
    @Binding var goToMemoryView: Bool
    @Binding var goToHomeView: Bool
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var viewModel: LocationViewModel
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
                        let apiService = APIService()
                        apiService.getCurrentPlaceName { (placeName, error) in
                            if let error = error {
                                print("Error fetching place name: \(error.localizedDescription)")
                            } else if let placeName = placeName {
                                print("Place name found \(placeName)")
                                viewModel.saveLocation(name: placeName, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, time: location.timestamp.formatted())
                            } else {
                                print("Place name could not be determined.")
                            }
                        }
                    }
                }
            } else {
                Text("Error Fetching location...")
            }
        }
    }
}
