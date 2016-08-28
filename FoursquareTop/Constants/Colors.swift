// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#elseif os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#endif

extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

enum ColorName {
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#333333"></span>
  /// Alpha: 100% <br/> (0x333333ff)
  case DarkTextPrimary
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#666666"></span>
  /// Alpha: 100% <br/> (0x666666ff)
  case DarkTextSecondary
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#34a9dd"></span>
  /// Alpha: 100% <br/> (0x34a9ddff)
  case FtopBlue
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#60b500"></span>
  /// Alpha: 100% <br/> (0x60b500ff)
  case FtopGreen
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffc533"></span>
  /// Alpha: 20% <br/> (0xffc53333)
  case FtopLightYellow
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff5a33"></span>
  /// Alpha: 100% <br/> (0xff5a33ff)
  case FtopOrange
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffc533"></span>
  /// Alpha: 100% <br/> (0xffc533ff)
  case FtopYellow

  var rgbaValue: UInt32 {
    switch self {
    case .DarkTextPrimary: return 0x333333ff
    case .DarkTextSecondary: return 0x666666ff
    case .FtopBlue: return 0x34a9ddff
    case .FtopGreen: return 0x60b500ff
    case .FtopLightYellow: return 0xffc53333
    case .FtopOrange: return 0xff5a33ff
    case .FtopYellow: return 0xffc533ff
    }
  }

  var color: Color {
    return Color(named: self)
  }
}

extension Color {
  convenience init(named name: ColorName) {
    self.init(rgbaValue: name.rgbaValue)
  }
}
