import Foundation
import CoreLocation
import Unbox

/// Photo location.
public struct PhotoLocation: Unboxable {

    // MARK: - Attributes

    /// Location name.
    public let name: String?

    /// Location city.
    public let city: String?

    /// Location country.
    public let country: String?

    /// Location coordinates.
    public let location: CLLocation?

    // MARK: - Unboxable

    /// Initialize an instance of this model by unboxing a dictionary using an Unboxer
    public init(unboxer: Unboxer) throws {
        self.name = unboxer.unbox(key: "name")
        self.city = unboxer.unbox(key: "city")
        self.country = unboxer.unbox(key: "country")
        if let latitude: Double = unboxer.unbox(key: "position.latitude"),
            let longitude: Double = unboxer.unbox(key: "position.longitude") {
            self.location = CLLocation(latitude: latitude, longitude: longitude)
        } else {
            self.location = nil
        }
    }

}
