import Foundation
import MAMapKit

class ClusterAnnotation: NSObject, MAAnnotation {
    var coordinate: CLLocationCoordinate2D // poi的平均位置
    var count: Int
    var pois: NSMutableArray
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, count: Int) {
        self.coordinate = coordinate
        self.count = count
        self.pois = NSMutableArray(capacity: count)
        super.init()
    }
    
    override var hash: Int {
        let toHash = String(format: "%.5f%.5f%ld", coordinate.latitude, coordinate.longitude, Int64(count))
        return toHash.hash
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ClusterAnnotation else {
            return false
        }
        return self.hash == other.hash
    }
}
