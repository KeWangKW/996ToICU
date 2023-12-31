//
//  UIColorExt.swift
//  BaseSwift
//
//  Created by 渴望 on 2020/5/19.
//  Copyright © 2020 渴望. All rights reserved.
//

import UIKit

// MARK: - Enum
public extension UIColor {
    
    @objc enum Custom:Int {
        case title, content, assist
        case section, line
        case background
        case base
        case White
        
        func style() -> Style {
            switch self {
            case .title:            return Style(light: 0x1A1919, dark: 0xFFFFFF)
            case .content:          return Style(light: 0x6F7172, dark: 0xFFFFFF)
            case .assist:           return Style(light: 0x9A9B9D, dark: 0xFFFFFF)
            case .section:          return Style(light: 0xF8F8F8, dark: 0xFFFFFF)
            case .line:             return Style(light: 0xDDDDDD, dark: 0xFFFFFF)
            case .background:       return Style(light: 0xFFFFFF, dark: 0x000000)
            case .base:             return Style(light: 0x0069B7, dark: 0xFFB400)
            case .White:            return Style(light: 0xFFFFFF)
            }
        }
    }
    
    struct Style {
        let light: UInt64
        //var dark: UInt64 = 0xFFFFFF
        var dark: UInt64 = 999999999999999
    }
}

public extension UIColor {
    
    
    /// 使用自定义色值，适配暗黑模式 (未设置dark色值时全输出light色值)
    /// - Parameter custom: 枚举
    /// - Returns: 颜色
    @objc static func KW_LD(_ custom: Custom) -> UIColor {
        let style = custom.style()
        guard #available(iOS 13.0, *) else { return UIColor(hex: style.light) }
        return UIColor(
            light: UIColor(hex: style.light),
            dark: style.dark == 999999999999999 ? UIColor(hex: style.light) : UIColor(hex: style.dark)
        )
    }
    
    /// 使用自定义色值，仅使用Light值
    /// - Parameter custom: 枚举
    /// - Returns: 颜色
    @objc static func KW_L(_ custom: Custom) -> UIColor {
        let style = custom.style()
        return UIColor(hex: style.light)
    }
    
    /// 使用自定义色值，仅使用Dark值
    /// - Parameter custom: 枚举
    /// - Returns: 颜色
    @objc static func KW_D(_ custom: Custom) -> UIColor {
        let style = custom.style()
        return style.dark == 999999999999999 ? UIColor(hex: style.light) : UIColor(hex: style.dark)
    }
    
    
    /// 快捷初始化两种模式颜色
    /// - Parameters:
    ///   - light: 正常模式下的颜色
    ///   - dark: 深色模式下的颜色
    @objc convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, *) {
            self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
    
    
    
    /// 随机色值
    @objc static var random: UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)),
                       g: CGFloat(arc4random_uniform(256)),
                       b: CGFloat(arc4random_uniform(256)))
    }
    
    
    
    @objc static func HexColor(str:NSString ,alpha: CGFloat = 1) ->UIColor {
        return UIColor(hexString: str as String ,alpha:alpha )
    }
    
}


// MARK: - Convenience
public extension UIColor {
    
    /// 通过字符串数值初始化颜色
    /// - Parameters:
    ///   - sHex: 字符串色值 ("#FFFFFF", "##FFFFFF", "0xFFFFFF")
    ///   - alpha: 透明度 默认1
    convenience init?(sHex: String, alpha: CGFloat = 1.0) {
        if sHex.isEmpty { return nil }
        
        var value = sHex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if value.count == 0 { return nil }
        
        if value.hasPrefix("##") || value.hasPrefix("0x") {
            value = String(value.suffix(value.count - 2))
        }
        
        if value.hasPrefix("#") {
            value = String(value.suffix(value.count - 1))
        }
        
        guard value.count == 6 else { return nil }
        
        let scanner = Scanner(string: "\(value)")
        var hex: UInt64 = 0
        guard scanner.scanHexInt64(&hex) else { return nil }
        
        self.init(hex: hex, alpha: alpha)
    }
    
    
    /// 通过16进制初始化颜色
    /// - Parameters:
    ///   - hex: 16进制色值 (eg: 0xFFFFFF)
    ///   - alpha: 透明度
    convenience init(hex: UInt64, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16)
        let green = CGFloat((hex & 0xFF00) >> 8)
        let blue = CGFloat(hex & 0xFF)
        self.init(r: red, g: green, b: blue, alpha: alpha)
    }
    
    
    /// 使用RGB快捷初始化色值
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    
    
}

// MARK: - Convenience
public extension UIColor {
     
    // Hex String -> UIColor
    @objc convenience init(hexString: String , alpha: CGFloat = 1.0) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
     
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
         
        let multiplier = CGFloat(255.999999)
         
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
         
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}

