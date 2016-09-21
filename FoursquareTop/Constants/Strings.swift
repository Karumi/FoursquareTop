// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum L10n {
  /// Close
  case Close
  /// Cancel
  case Cancel
  /// Loading
  case Loading
  /// An error just happened
  case ErrorViewAccesibilityLabel
  /// Best open places around you
  case BestPlacesAroundTitle
  /// There is no open places around you
  case VenuesListNoVenuesAroundYouError
  /// Could not fetch the venues, please tap anywhere to retry
  case VenuesListCanNotFetchVenuesError
  /// Could not fetch your location, please tap anywhere to retry
  case VenuesListCanNotFetchLocationError
  /// Can not access to your GPS
  case VenuesListNoGPSAccessError
  /// Ftop can not access to the GPS
  case VenuesListNoGPSAccessErrorTitle
  /// Please enable GPS in settings
  case VenuesListNoGPSAccessErrorMessage
  /// Open settings
  case VenuesListNoGPSAccessGoToGeneralSettings
  /// Directions
  case VenueDetailMapPickerTitle
  /// What do you want to use?
  case VenueDetailMapPickerMessage
  /// See Menu
  case VenueDetailSeeMenu
  /// Could not show this venue information, please tap anywhere to retry
  case VenueDetailCanNotFetchVenueError
  /// %lu de %lu
  case VenueDetailPhotoGalleryTitle(Int, Int)
  /// The venue's address
  case VenueDetailAddressAccessibilityLabel
  /// The venue's status
  case VenueDetailStatusAccessibilityLabel
  /// The venue's rating
  case VenueDetailRatingAccessibilityLabel
  /// The venue's pricing tag
  case VenueDetailPricingAccessibilityLabel
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .Close:
        return L10n.tr("Close")
      case .Cancel:
        return L10n.tr("Cancel")
      case .Loading:
        return L10n.tr("Loading")
      case .ErrorViewAccesibilityLabel:
        return L10n.tr("ErrorView.AccesibilityLabel")
      case .BestPlacesAroundTitle:
        return L10n.tr("BestPlacesAround.Title")
      case .VenuesListNoVenuesAroundYouError:
        return L10n.tr("VenuesList.NoVenuesAroundYou.Error")
      case .VenuesListCanNotFetchVenuesError:
        return L10n.tr("VenuesList.CanNotFetchVenues.Error")
      case .VenuesListCanNotFetchLocationError:
        return L10n.tr("VenuesList.CanNotFetchLocation.Error")
      case .VenuesListNoGPSAccessError:
        return L10n.tr("VenuesList.NoGPSAccess.Error")
      case .VenuesListNoGPSAccessErrorTitle:
        return L10n.tr("VenuesList.NoGPSAccess.ErrorTitle")
      case .VenuesListNoGPSAccessErrorMessage:
        return L10n.tr("VenuesList.NoGPSAccess.ErrorMessage")
      case .VenuesListNoGPSAccessGoToGeneralSettings:
        return L10n.tr("VenuesList.NoGPSAccess.GoToGeneralSettings")
      case .VenueDetailMapPickerTitle:
        return L10n.tr("VenueDetail.MapPicker.Title")
      case .VenueDetailMapPickerMessage:
        return L10n.tr("VenueDetail.MapPicker.Message")
      case .VenueDetailSeeMenu:
        return L10n.tr("VenueDetail.SeeMenu")
      case .VenueDetailCanNotFetchVenueError:
        return L10n.tr("VenueDetail.CanNotFetchVenue.Error")
      case .VenueDetailPhotoGalleryTitle(let p0, let p1):
        return L10n.tr("VenueDetail.PhotoGallery.Title", p0, p1)
      case .VenueDetailAddressAccessibilityLabel:
        return L10n.tr("VenueDetail.Address.AccessibilityLabel")
      case .VenueDetailStatusAccessibilityLabel:
        return L10n.tr("VenueDetail.Status.AccessibilityLabel")
      case .VenueDetailRatingAccessibilityLabel:
        return L10n.tr("VenueDetail.Rating.AccessibilityLabel")
      case .VenueDetailPricingAccessibilityLabel:
        return L10n.tr("VenueDetail.Pricing.AccessibilityLabel")
    }
  }

  private static func tr(key: String, _ args: CVarArgType...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: NSLocale.currentLocale(), arguments: args)
  }
}

func tr(key: L10n) -> String {
  return key.string
}
