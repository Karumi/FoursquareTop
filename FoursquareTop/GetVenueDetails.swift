
import Foundation
import Result

protocol GetVenueDetailsUseCase {
    func execute(id: String, callback: Result<VenueViewModel, NetworkError> -> ())
}

struct GetVenueDetails: GetVenueDetailsUseCase {
    
    private let dataSource: VenueDataSource
    
    init(dataSource: VenueDataSource) {
        self.dataSource = dataSource
    }
    
    func execute(id: String, callback: Result<VenueViewModel, NetworkError> -> ()) {
        dataSource.venue(withIdentifier: id) { result in
            if let venue = result.value {
                callback(Result(venue))
            }
        }
    }
}