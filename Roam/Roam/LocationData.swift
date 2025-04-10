//
//  LocationData.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//
import Foundation
import GooglePlaces
/*
 Raw photo metadata: attributions: Foxtail Coffee Ada Village, reference: places/ChIJ0dVqDrVRGIgRmn-MRB0mSQI/photos/AeeoHcKGGygBolD7ggU4Uxg3gPEvsqgTuB9lmn7QezB0OSWrr_pJA1HUZwUEOlxD4kzyuZmIzQ929IttHPd9KlEyL37HzdFOV9zPFtYmBG1B_QT4Bo-UMLiZFfFAVXUVsf3kcg_20OG5YhVeQNo6nK_XRmNlOaiYVb7R5BD06a7VseX9zDvSdPkSb9iLLdZ2TioflGNe0YLzNc7zSb9g_s-MCbUhmRTxfIWr22gPpsDF9n0mUZyqUkVy0e3YNXkxAxc_cM7on_w0JxnDcq4NMeBYCiHR_eF8UWriXkmJ-lYN-2J6nA, photo index: 0, max height: 3600.00, max width: 4800.00, author attributions: (
     "name: Foxtail Coffee Ada Village, uri: https://maps.google.com/maps/contrib/108700057070832891181, photo uri: https://lh3.googleusercontent.com/a-/ALV-UjUvszvWJMG5JkK8WaheRP3v4k34Nu3saalf5UlcLw4HJ_NvQEA=s100-p-k-no-mo"
 )
 */

struct LocationData: Identifiable, Codable {
    var id = UUID()
    var name: String?
    var latitude: Double
    var longitude: Double
    var date = Date()
}
