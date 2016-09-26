// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum Asset: String {
  case Alpha = "alpha"
  case Bg_map_alpha = "bg_map_alpha"
  case Ic_embarrassed = "ic_embarrassed"
  case Ic_foursquare = "ic_foursquare"
  case Ic_phone = "ic_phone"
  case Ic_sad = "ic_sad"
  case Image_Placeholder = "image-placeholder"

  var image: Image {
    return Image(asset: self)
  }
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
