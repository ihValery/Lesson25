import Foundation
import CoreLocation

struct Location {
    
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    var dict: [String : Any] {
        var dict: [String : Any] = [:]
        dict["name"] = name
        if let coordinate = coordinate {
            dict["latitude"] = coordinate.latitude
            dict["longitude"] = coordinate.longitude
        }
        return dict
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}

extension Location {
    
    typealias PlistDictionary = [String : Any]
    
    init?(dict: PlistDictionary) {
        self.name = dict["name"] as! String
        if let latitude = dict["latitude"] as? Double,
           let longitude = dict["longitude"] as? Double {
            self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        } else {
            self.coordinate = nil
        }
    }
}

extension Location: Equatable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        guard lhs.coordinate?.latitude == rhs.coordinate?.latitude &&
              lhs.coordinate?.longitude == rhs.coordinate?.longitude &&
              lhs.name == rhs.name else { return false }
        return true
    }
}
