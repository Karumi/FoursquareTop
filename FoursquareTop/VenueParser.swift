
import Foundation
import SwiftyJSON
import MapKit

private let VenueURLPrefix = "http://foursquare.com/venue/"
private let VenueAppURLPrefix = "foursquare://venues/"
private let VenueTipAppURL = "foursquare://tips/"
private let FoodCategoryFoursquareID = "4d4b7105d754a06374d81259"

enum CategoryImageSize : String {
    case Small = "bg_32"
    case Medium = "bg_44"
    case Big = "bg_64"
    case Max = "bg_88"
}

enum CategoryName {
    case Regular
    case Short
    case Plural
}

struct VenueParser {
    
    func parseVenueList(response: AnyObject) -> VenueListViewModel {
        let json = JSON(response)
        var venues: [VenueViewModel] = []
        
        if let list = json["groups"].array?.first, items = list["items"].array {
            venues = items.map {
                self.parseVenue($0["venue"], tips: $0["tips"].array?.map(parseTip) ?? [])
            }
        }
        
        return VenueListViewModel(venues: venues)
    }
    
    private func parseVenue(json: JSON, tips: [VenueTipViewModel]) -> VenueViewModel {
        
        let categories = json["categories"].array?.map(parseCategory) ?? []
        let photos = json["photos"]["groups"]["items"].array?.map(parsePhoto) ?? []
        let id = json["id"].stringValue
        
        return VenueViewModel(
            foursquareID: id,
            name: json["name"].stringValue,
            URL: NSURL(string: String(format: "%@%@", VenueURLPrefix, id)),
            foursquareURL: NSURL(string: String(format: "%@%@", VenueAppURLPrefix, id)),
            menuURL: NSURL(string: json["menu"]["mobileUrl"].stringValue),
            reservationsURL: NSURL(string: json["reservations"]["url"].stringValue),
            websiteURL: NSURL(string: json["url"].stringValue),
            phone: json["contact"]["phone"].stringValue,
            address: json["location"]["address"].stringValue,
            price: VenuePrice(value: json["price"]["tier"].intValue),
            likesCount: json["likes"]["count"].intValue,
            rating: json["rating"].doubleValue,
            location: CLLocation(
                latitude: json["location"]["lat"].doubleValue,
                longitude: json["location"]["long"].doubleValue
            ),
            distance: json["location"]["distance"].doubleValue,
            categories: categories,
            tips: tips,
            photos: photos
        )
    }
    
    private func parseCategory(json: JSON) -> VenueCategoryViewModel {
        return VenueCategoryViewModel(
            identifier: json["id"].stringValue,
            images: VenueCategoryImages(
                sizes: [
                    .Small : urlForCategoryImage(json, size: .Small),
                    .Medium : urlForCategoryImage(json, size: .Medium),
                    .Big : urlForCategoryImage(json, size: .Big),
                    .Max : urlForCategoryImage(json, size: .Max)
                ]
            ),
            names: VenueCategoryNames(
                names: [
                    .Regular : json["name"].stringValue,
                    .Short : json["shortName"].stringValue,
                    .Plural : json["pluralName"].stringValue,
                ]
            ),
            primary: json["primary"].intValue == 1
        )
    }
    
    private func parsePhoto(json: JSON) -> VenuePhotoViewModel {
        return VenuePhotoViewModel(
            identifier: json["id"].stringValue,
            url: NSURL(
                string: String(format: "%@original%@", json["prefix"].stringValue, json["suffix"].stringValue)
            )
        )
    }
    
    private func parseTip(json: JSON) -> VenueTipViewModel {
        let id = json["id"].stringValue
        
        return VenueTipViewModel(
            identifier: id,
            URL: NSURL(string: json["canonicalUrl"].stringValue),
            foursquareURL: NSURL(string: String(format: "%@%@", VenueTipAppURL, id)),
            likesCount: json["likes"]["count"].intValue,
            text: json["text"].stringValue
        )
    }
    
    private func urlForCategoryImage(json: JSON, size: CategoryImageSize) -> NSURL {
        let urlString = String(format: "%@\(size.rawValue)%@", json["icon"]["prefix"].stringValue, json["icon"]["suffix"].stringValue)
        return NSURL(string: urlString)!
    }
}