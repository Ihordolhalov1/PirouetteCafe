//
//  SwiftUIView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 23.05.2024.
//

import SwiftUI
import MapKit



struct ShortMapView: View {
    var interactionModes: MapInteractionModes = .all
 
    
    @State private var region: MKCoordinateRegion
    @State private var annotatedItem: AnnotatedItem
    
    init() {
        // Center coordinates
        let latitude = 52.53125
        let longitude = 13.4125
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let regionRadius: CLLocationDistance = 200 // 400 meters
        let region = MKCoordinateRegion(center: centerCoordinate,
                                        latitudinalMeters: regionRadius,
                                        longitudinalMeters: regionRadius)
        
        // Initialize state variables
        _region = State(initialValue: region)
        _annotatedItem = State(initialValue: AnnotatedItem(coordinate: centerCoordinate))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: interactionModes, annotationItems: [annotatedItem]) { item in
            MapMarker(coordinate: item.coordinate, tint: .red)
        }
        .frame(width: 150, height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()    }
}

#Preview {
    ShortMapView()
}
