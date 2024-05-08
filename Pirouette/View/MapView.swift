//
//  MapView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 07.05.2024.
//

import SwiftUI
import MapKit

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
       var interactionModes: MapInteractionModes = .all
    
       
       @State private var region: MKCoordinateRegion
       @State private var annotatedItem: AnnotatedItem
       
       init() {
           // Center coordinates
           let latitude = 52.53125
           let longitude = 13.4125
           let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
           
           let regionRadius: CLLocationDistance = 400 // 400 meters
           let region = MKCoordinateRegion(center: centerCoordinate,
                                           latitudinalMeters: regionRadius,
                                           longitudinalMeters: regionRadius)
           
           // Initialize state variables
           _region = State(initialValue: region)
           _annotatedItem = State(initialValue: AnnotatedItem(coordinate: centerCoordinate))
       }
    
   
    

    
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Image("sign").resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100).padding()
                    Text("Pipouette CafeBar").bold().font(.title)
                }
                
                HStack {
                    Image(systemName: "location")
                    Text("Saarbrücker Straße 17, Berlin")
                }.padding(.horizontal)
                 //   .padding(.vertical, 8)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                                        openMaps(address: "Saarbrücker Straße 17, Berlin")
                                    }
                
                HStack {
                    Image(systemName: "teletype")
                    Text("+49 176 70606036")
                }.padding(.horizontal)
                    .foregroundStyle(.blue)
                    .padding(.vertical, 8)

                    .onTapGesture {
                                        callPhoneNumber(phoneNumber: "+4917670606036")
                                    }
                
                HStack {
                    Image(systemName: "envelope")
                    Text("pirouette.cafebar@gmail.com")
                }.padding(.horizontal)
                    .padding(.vertical, 8)
                    .foregroundStyle(.blue)
                
                HStack {
                    Text("  f  ")
                        .bold().background(.blue).foregroundStyle(.white).font(.title2).clipShape(RoundedRectangle(cornerRadius: 12))
                    Text("pirouette.cafebar").foregroundStyle(.blue)
                }.padding(.horizontal)
                    .padding(.vertical, 8)
                    .onTapGesture {
                        openFacebookApp()
                    }
                
                VStack(alignment: .leading) {
                    Text("Hours of Operation").bold()
                    Text("""
                                Monday: 11:00 AM - 11:00 PM
                                Tuesday: 11:00 AM - 11:00 PM
                                Wednesday: 11:00 AM - 11:00 PM
                                Thursday: 11:00 AM - 11:00 PM
                                Friday: 11:00 AM - 11:00 PM
                                Saturday: 10:00 AM - 11:00 PM
                                Sunday: 10:00 AM - 10:00 PM
                                """)
                    .multilineTextAlignment(.leading)
                    .italic()
                }   .padding(.horizontal)
                    .padding(.vertical, 8)
                
                Map(coordinateRegion: $region, interactionModes: interactionModes, annotationItems: [annotatedItem]) { item in
                    MapMarker(coordinate: item.coordinate, tint: .red)
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            }
        }
    }
    
    
    
    
    func openMaps(address: String) {
        // Encode the address for URL
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // Create the URL string for Apple Maps
        let mapURLString = "http://maps.apple.com/?address=\(encodedAddress)"
        
        // Create URL from the string
        if let mapURL = URL(string: mapURLString) {
            // Open Apple Maps with the specified address
            UIApplication.shared.open(mapURL, options: [:], completionHandler: nil)
        }
    }
    
    func callPhoneNumber(phoneNumber: String) {
            if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
    
    func openFacebookApp() {
        let facebookURLString = "fb://profile/pirouette.cafebar/"
        let facebookWebURLString = "https://www.facebook.com/pirouette.cafebar/"
        
        guard let facebookURL = URL(string: facebookURLString), UIApplication.shared.canOpenURL(facebookURL) else {
            // Facebook app not installed, open Facebook in web browser
            if let facebookWebURL = URL(string: facebookWebURLString) {
                UIApplication.shared.open(facebookWebURL, options: [:], completionHandler: nil)
            }
            return
        }
        
        // Open Facebook app
        UIApplication.shared.open(facebookURL, options: [:], completionHandler: nil)
    }
    
    
    }


    struct MapView_Previews: PreviewProvider {
        static var previews: some View {
            MapView()
        }
    }

