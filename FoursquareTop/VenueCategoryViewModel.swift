
import Foundation

struct VenueCategoryImages {
    let sizes: [CategoryImageSize:NSURL]
    
    func get(forSize size: CategoryImageSize) -> NSURL {
        return sizes[size]!
    }
}

struct VenueCategoryNames {
    let names: [CategoryName:String]
    
    func get(forType type: CategoryName) -> String {
        return names[type]!
    }
}

struct VenueCategoryViewModel : Hashable {
    let identifier: String
    let images: VenueCategoryImages
    let names: VenueCategoryNames
    let iconURL: NSURL?
    let primary: Bool
    
    var hashValue: Int {
        return 0
    }
}

func ==(lhs: VenueCategoryViewModel, rhs: VenueCategoryViewModel) -> Bool {
    return lhs.identifier == rhs.identifier
}