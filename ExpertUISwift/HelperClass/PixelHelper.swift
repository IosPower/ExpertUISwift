//
//  PixelHelper.swift
//  ExpertUISwift
//
//  Created by piyush sinroja on 25/04/18.
//  Copyright © 2018 piyush. All rights reserved.
//

import UIKit

public class PixelHelper: NSObject {
    public static let objPixelHelper = PixelHelper()
    public static var defaultScreenWidth: CGFloat = DefaultTookWidthPixels.iPhone8Plus.rawValue   // In pixel
    
    public static var defaultScreenHeight: CGFloat = DefaultTookHeightPixels.iPhone8Plus.rawValue  // In pixel
    
    // For Iphone 5 and 6,7,8 Set TwoX, for Iphone 6+,7+,8+,10 set Threex
    public var pixelMulti: CGFloat = DefaultTwoXOrThreeX.threeXScreen.rawValue
    
    public enum DefaultTwoXOrThreeX: CGFloat {
        case twoXScreen = 2, threeXScreen
    }
    
    public enum DefaultTookWidthPixels: CGFloat {
        case iPhone5 = 640
        case iPhone8 = 750
        case iPhone8Plus = 1242
        case iPhoneX = 1125
    }
    
    public enum DefaultTookHeightPixels: CGFloat {
        case iPhone5 = 1136
        case iPhone8 = 1334
        case iPhone8Plus = 2208
        case iPhoneX = 2436
    }
    
    /// setXPositionAutomatic
    ///
    /// - Parameter value: Constraint Constant Value
    /// - Returns: Constraint Constant Value Accroding To Device
    static func setXPositionAutomatic(value: CGFloat) -> CGFloat {
        var xposition: CGFloat = value * objPixelHelper.pixelMulti             // in pixels
        return xposition.setXPositionAutomatic(constrInPixel: xposition)
    }
    static func setYPositionAutomatic(value: CGFloat) -> CGFloat {
        var yposition: CGFloat = value * objPixelHelper.pixelMulti             // in pixels
        return yposition.setYPositionAutomatic(constrInPixel: yposition)
    }
    
    // MARK: - Class Function For Set ConstraintAutomatic
    /// setConstraintAutomatic
    ///
    /// - Parameter constr: Array Of NSLayoutConstraint
    public class func setConstraintAutomatic(constr: [NSLayoutConstraint]) {
        for constraint in constr {
            switch constraint.firstAttribute {
            case .top, .bottom, .centerY, .centerYWithinMargins, .height, .topMargin, .bottomMargin, .lastBaseline, .firstBaseline:
                
                print("Y")
                constraint.constant = self.setYPositionAutomatic(value: constraint.constant)
            case .centerX, .centerXWithinMargins, .width, .left, .leading, .leftMargin, .leadingMargin, .right, .rightMargin, .trailing, .trailingMargin:
                
                print("X")
                constraint.constant = self.setXPositionAutomatic(value: constraint.constant)
            default :
                print("notAnAttribute")
            }
        }
    }
    
    // MARK: - Class Function For Set FontForDevice
    /// setFontForDevice
    ///
    /// - Parameter constr: Array Of Class (Label, Button, TextView, TextField)
    public class func setFontForDevice(obj: [AnyObject]) {
        for objClass in obj {
            switch objClass {
            case is UILabel:
                if let lbl: UILabel = objClass as? UILabel {
                    lbl.setFontForDevice(fontName: nil, sizeofFont: nil)
                }
            case is UIButton:
                if let btn: UIButton = objClass as? UIButton {
                     btn.setFontForDevice(fontName: nil, sizeofFont: nil)
                }
            case is UITextField:
                if let txt: UITextField = objClass as? UITextField {
                    txt.setFontForDevice(fontName: nil, sizeofFont: nil)
                }
            case is UITextView:
                if let txtView: UITextView = objClass as? UITextView {
                    txtView.setFontForDevice(fontName: nil, sizeofFont: nil)
                }
            default :
                break
            }
        }
    }
}

// MARK: - Constaraint Constant Change According To Device Pixels
extension CGFloat {
    fileprivate mutating func setXPositionAutomatic(constrInPixel: CGFloat) -> CGFloat {
        let screenheight = UIScreen.main.bounds.size.height
        switch screenheight {
        //Iphone 4, //Iphone 5
        case 480, 568:
            self = (constrInPixel * 640)/PixelHelper.defaultScreenWidth
            self /= 2
        //Iphone 8
        case 667:
            self = (constrInPixel * 750)/PixelHelper.defaultScreenWidth
            self /= 2
        //Iphone 8plus
        case 736:
            self = (constrInPixel * 1242)/PixelHelper.defaultScreenWidth
            self /= 3
        //Iphone X
        case 812:
            self = (constrInPixel * 1125)/PixelHelper.defaultScreenWidth
            self /= 3
        default:
            self = constrInPixel
        }
        print(self)
        return self
    }

    fileprivate mutating func setYPositionAutomatic(constrInPixel: CGFloat) -> CGFloat {
        let screenheight = UIScreen.main.bounds.size.height
        switch screenheight {
        //Iphone 4
        case 480:
            self = (constrInPixel * 960)/PixelHelper.defaultScreenHeight
            self /= 2
        //Iphone 5
        case 568:
            self = (constrInPixel * 1136)/PixelHelper.defaultScreenHeight
            self /= 2
        //Iphone 8
        case 667:
            self = (constrInPixel * 1334)/PixelHelper.defaultScreenHeight
            self /= 2
        //Iphone 8plus
        case 736:
            self = (constrInPixel * 2208)/PixelHelper.defaultScreenHeight
            self /= 3
        //Iphone X
        case 812:
            self = (constrInPixel * 2436)/PixelHelper.defaultScreenHeight
            self /= 3
        default:
            self = constrInPixel
        }
        print(self)
        return self
    }
}

public extension UILabel {
    public func setFontForDevice(fontName: String?, sizeofFont: CGFloat?) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if sizeofFont != nil {
            fontSize = sizeofFont!
        }
        var newSize = fontSize * PixelHelper.objPixelHelper.pixelMulti
        newSize = newSize.setYPositionAutomatic(constrInPixel: newSize)
        self.font = UIFont(name: nameOfFont!, size: newSize)!
    }
}

public extension UIButton {
    public func setFontForDevice(fontName: String?, sizeofFont: CGFloat?) {
        var nameOfFont = self.titleLabel?.font.fontName
        var fontSize: CGFloat = (self.titleLabel?.font.pointSize)!
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if sizeofFont != nil {
            fontSize = sizeofFont!
        }
        var newSize = fontSize * PixelHelper.objPixelHelper.pixelMulti
        newSize = newSize.setYPositionAutomatic(constrInPixel: newSize)
        self.titleLabel?.font = UIFont(name: nameOfFont!, size: newSize)!
    }
}

public extension UITextField {
    public func setFontForDevice(fontName: String?, sizeofFont: CGFloat?) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if sizeofFont != nil {
            fontSize = sizeofFont!
        }
        var newSize = fontSize * PixelHelper.objPixelHelper.pixelMulti
        newSize = newSize.setYPositionAutomatic(constrInPixel: newSize)
        self.font = UIFont(name: nameOfFont!, size: newSize)!
    }
}

public extension UITextView {
    public func setFontForDevice(fontName: String?, sizeofFont: CGFloat?) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if sizeofFont != nil {
            fontSize = sizeofFont!
        }
        var newSize = fontSize * PixelHelper.objPixelHelper.pixelMulti
        newSize = newSize.setYPositionAutomatic(constrInPixel: newSize)
        self.font = UIFont(name: nameOfFont!, size: newSize)!
    }
}
