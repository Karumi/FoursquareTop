
import Foundation
import MapKit
import SwiftyJSON
import QuadratTouch
import enum Result.Result

enum NetworkError : ErrorType {
    case Generic
    case EmptyResult
}

class VenueDataSource {

    private lazy var session: Session = {
        let client = Client(
            clientID: "XSVTFQRZJZWJN2PUN4LCBNLD1BRHVVX0N1ZDHK2QQBRHH5UC",
            clientSecret: "NJCFSJVQ4QMVKQ5W2MWBGCSTQ5RSDLG3WRC3SESDMZZRMJQP",
            redirectURL: "http://gokarumi.com/best-restaurant/redirect"
        )
        var configuration = Configuration(client:client)
        Session.setupSharedSessionWithConfiguration(configuration)
        
        return Session.sharedSession()
    }()
    
    func topVenues(atLocation location: CLLocation, callback: (Result<VenueListViewModel, NetworkError>) -> ()) {
     
        self.session.venues.explore(
            [
                "ll" : "\(location.coordinate.latitude),\(location.coordinate.longitude)",
                "llAcc": "200",
                "radius": "1000",
                "limit": "50",
                "openNow": "1",
                "sortByDistance": "0",
                "section": "food"
            ]
        ) { result in
            if let response = result.response {
                let parser = VenueParser()
                callback(Result(parser.parseVenueList(response)))
            }
        }.start()
    }
    
    func venue(withIdentifier id: String, callback: (Result<VenueViewModel, NetworkError>) -> ()) {
    
        self.session.venues.get(id) { result in
            if let response = result.response {
                let parser = VenueParser()
                callback(Result(parser.parseVenue(response)))
            }
        }.start()
        
    }
}