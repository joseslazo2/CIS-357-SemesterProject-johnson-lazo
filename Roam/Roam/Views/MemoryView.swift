//
//  MemoryView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//

import SwiftUI
import GooglePlaces

struct MemoryView: View {
    @Binding var goToAddView: Bool
    @Binding var goToMemoryView: Bool
    @Binding var goToHomeView: Bool
    @EnvironmentObject var viewModel: LocationViewModel
    @State private var images: [UUID: UIImage] = [:]
    
    var body: some View {
        VStack {
            Spacer()
            List {
                ForEach(viewModel.locations) { locationItem in
                    VStack(alignment: .leading) {
                        Button(action: {
                            // TODO - add action where when location item is pressed
                        }){
                            VStack {
                                Text(locationItem.name ?? "error getting name")
                                Text("Lat: \(locationItem.latitude), Long: \(locationItem.longitude)")
                                Text("Date: \(locationItem.date)")
                                /*
                                 if let photo = currentPhoto {
                                     Image(uiImage: photo)
                                         .resizable()
                                         .scaledToFit()
                                         .frame(maxHeight: 300)
                                         .padding()
                                 }
                                 
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
                                 */
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            Spacer()
            
            // ---------- NAVIGATION BAR ----------
            HStack {
                Button(action: {
                    goToHomeView = true
                    goToAddView = false
                    goToMemoryView = false
                }) {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.white)
                }
                
                Spacer()
                
                Button(action: {
                    goToAddView = true
                    goToMemoryView = false
                    goToHomeView = false
                }){
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.white)
                }
                Spacer()
                
                Button(action:{
                    goToMemoryView = true
                    goToHomeView = false
                    goToAddView = false
                }){
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(Color.gray)
        }
        .onAppear {
            startListener(viewModel: viewModel)
        }
        .onDisappear {
            stopListener()
        }
    }
    func delete(at offsets: IndexSet) {
        let location = viewModel.locations[offsets.first ?? 0]
        Task {
            await deleteLocation(location: location)
        }
    }
    
    /*
    private func fetchPhoto(reference: String, locationId: UUID) {
        let photoMetadata = GMSPlacePhotoMetadata(reference: reference)
        let fetchPhotoRequest = GMSFetchPhotoRequest(
            photoMetadata: photoMetadata,
            maxSize: CGSize(width: 1200, height: 1200)
        )
        
        GMSPlacesClient.shared().fetchPhoto(with: fetchPhotoRequest) { image, error in
            if let error = error {
                print("Error loading photo: \(error.localizedDescription)")
                return
            }
            
            if let image = image {
                DispatchQueue.main.async {
                    images[locationId] = image
                }
            }
        }
    }
    */
}
