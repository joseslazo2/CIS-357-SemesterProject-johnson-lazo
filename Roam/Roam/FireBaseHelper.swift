import FirebaseFirestore
import Foundation

let db = Firestore.firestore()
var listener : ListenerRegistration? = nil

func addLocation(location: LocationData) async {
    do {
        try await db.collection("locations").document(location.id.uuidString).setData([
            "name": location.name,
            "latitude": location.latitude,
            "longitude": location.longitude,
            "date": location.date
        ])
        print("Location added successfully")
    } catch {
        print("Error adding location: \(error)")
    }
}

func startListener(viewModel: LocationViewModel) {
    listener = db.collection("locations")
        .addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                 print("Error fetching documents: \(error!)")
                return
            }
            var parsedLocations = [LocationData]()
            for document in documents {
                let id = document.documentID
                let data = document.data()
                let name = data["name"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? 0.0
                let longitude = data["longitude"] as? Double ?? 0.0
                let date = data["date"] as? Date ?? Date()
                let item = LocationData(id: UUID(uuidString: id) ?? UUID(), name: name, latitude: latitude, longitude: longitude, date: date)
                parsedLocations.append(item)
            }
            print("Read \(parsedLocations.count) locations from Firestore")
            Task { @MainActor in 
                viewModel.locations = parsedLocations
            }
        }
}

func stopListener() {
    if let l = listener {
        l.remove()
    }
}

func deleteLocation(location: LocationData) async {
    do {
        try await db.collection("locations").document(location.id.uuidString).delete()
        print("Location deleted successfully")
    } catch {
        print("Error deleting location: \(error)")
    }
}
