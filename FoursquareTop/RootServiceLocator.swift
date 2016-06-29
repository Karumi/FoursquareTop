
import UIKit

class RootServiceLocator : NSObject {
    
//    let user: UserServiceLocator
//    let appInitialization: AppInitializationServiceLocator
//    let advert: AdvertServiceLocator
//    let favorites: FavoritesServiceLocator
//    let help: HelpServiceLocator
//    let gta: ScaffoldingGTAServiceLocator
//    
    private(set) static var instance: RootServiceLocator = RootServiceLocator.Builder().build()
    
    static func override(rootServiceLocator: RootServiceLocator) {
        RootServiceLocator.instance = rootServiceLocator
    }
    
//    private convenience override init() {
//        self.init(
//            user: UserServiceLocator(),
//            appInitialization: AppInitializationServiceLocator(),
//            advert: AdvertServiceLocator(),
//            favorites: FavoritesServiceLocator(),
//            help: HelpServiceLocator(),
//            gta: ScaffoldingGTAServiceLocator()
//        )
//    }
    
    private override init(
//        user: UserServiceLocator,
//        appInitialization: AppInitializationServiceLocator,
//        advert: AdvertServiceLocator,
//        favorites: FavoritesServiceLocator,
//        help: HelpServiceLocator,
//        gta: ScaffoldingGTAServiceLocator
        ) {
//        self.user = user
//        self.appInitialization = appInitialization
//        self.advert = advert
//        self.favorites = favorites
//        self.help = help
//        self.gta = gta
    }
    
    func getInitialViewController() -> UINavigationController {
        let vc = BestVenuesAroundYouViewController()
        vc.venuesAroudYouPresenter = BestVenuesAroundYouPresenter(ui: vc)
        
        return UINavigationController(rootViewController: vc)
    }
    
    class Builder {
//        var user = UserServiceLocator()
//        var appInitialization = AppInitializationServiceLocator()
//        var advert = AdvertServiceLocator()
//        var favorites = FavoritesServiceLocator()
//        var help = HelpServiceLocator()
//        var gta = ScaffoldingGTAServiceLocator()
        
        init() {
            
        }
        
        init(serviceLocator: RootServiceLocator) {
//            user = serviceLocator.user
//            appInitialization = serviceLocator.appInitialization
//            advert = serviceLocator.advert
//            favorites = serviceLocator.favorites
//            help = serviceLocator.help
//            gta = serviceLocator.gta
        }
        
//        func withUser(user: UserServiceLocator) -> Builder {
//            self.user = user
//            return self
//        }
//        
//        func withAppInitialization(appInitialization: AppInitializationServiceLocator) -> Builder {
//            self.appInitialization = appInitialization
//            return self
//        }
//        
//        func withAdvert(advert: AdvertServiceLocator) -> Builder {
//            self.advert = advert
//            return self
//        }
//        
//        func withFavorites(favorites: FavoritesServiceLocator) -> Builder {
//            self.favorites = favorites
//            return self
//        }
//        
//        func withHelp(help: HelpServiceLocator) -> Builder {
//            self.help = help
//            return self
//        }
//        
//        func withGTA(gta: ScaffoldingGTAServiceLocator) -> Builder {
//            self.gta = gta
//            return self
//        }
        
        func build() -> RootServiceLocator {
            let rootServiceLocator = RootServiceLocator(
//                user: user,
//                appInitialization: appInitialization,
//                advert: advert,
//                favorites: favorites,
//                help: help,
//                gta: gta
            )
            
//            user.rootServiceLocator = rootServiceLocator
//            appInitialization.rootServiceLocator = rootServiceLocator
//            advert.rootServiceLocator = rootServiceLocator
//            favorites.rootServiceLocator = rootServiceLocator
//            help.rootServiceLocator = rootServiceLocator
//            gta.rootServiceLocator = rootServiceLocator
            
            return rootServiceLocator
        }
    }
}