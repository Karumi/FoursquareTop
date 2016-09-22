//
//  VenueViewModel+Builder.swift
//  FoursquareTop
//
//  Created by Fran on 9/21/16.
//  Copyright © 2016 Karumi. All rights reserved.


import Foundation
import MapKit

@testable import FoursquareTop

extension VenueViewModel {

    static func build(
        foursquareID: String = "",
        name: String = "Venue name",
        URL: NSURL? = nil,
        foursquareURL: NSURL? = nil,
        menu: NSURL? = nil,
        reservationsURL: NSURL? = nil,
        websiteURL: NSURL? = nil,
        phone: String? = nil,
        address: String? = nil,
        status: String? = nil,
        price: VenuePrice? = nil,
        phrases: [VenuePhraseViewModel] = [],
        likesCount: Int = 0,
        rating: Double? = nil,
        location: CLLocation = CLLocation(latitude: 0, longitude: 0),
        distance: Double? = nil,
        categories: [VenueCategoryViewModel] = [VenueCategoryViewModel.build("")],
        tips: [VenueTipViewModel] = [],
        photos: [VenuePhotoViewModel] = []
    ) -> VenueViewModel {
        return VenueViewModel(
            foursquareID: foursquareID,
            name: name,
            URL: URL,
            foursquareURL: foursquareURL,
            menuURL: menu,
            reservationsURL: reservationsURL,
            websiteURL: websiteURL,
            phone: phone,
            address: address,
            status: status,
            price: price,
            phrases: phrases,
            likesCount: likesCount,
            rating: rating,
            location: location,
            distance: distance,
            categories: categories,
            tips: tips,
            photos: photos
        )
    }
}

extension VenueCategoryViewModel {
    
    static func build (suffix : String) -> VenueCategoryViewModel {
        return VenueCategoryViewModel(
            identifier: "category_\(suffix)",
            images: VenueCategoryImages(sizes: [:]),
            names: VenueCategoryNames.build("\(suffix)"),
            iconURL: nil,
            primary: true
        )
    }
    
}

extension VenueCategoryNames {
    static func build (suffix : String) -> VenueCategoryNames {
    return VenueCategoryNames(
        names: [
            .Regular: "Regular Category Name - \(suffix)",
            .Short: "Short CN - \(suffix)",
            .Plural: "Plural CN - \(suffix)",
        ])
    }
}

extension VenueTipViewModel {
    static func build(
        identifier: String = "",
        URL: NSURL? = nil,
        foursquareURL: NSURL? = nil,
        likesCount: Int = 0,
        text: String = ""
        ) -> VenueTipViewModel {
        return VenueTipViewModel(
            identifier: identifier,
            URL: URL,
            foursquareURL: foursquareURL,
            likesCount: likesCount,
            text: text
        )
    }
}
