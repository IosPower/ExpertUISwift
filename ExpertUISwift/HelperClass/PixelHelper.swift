//
//  PixelHelper.swift
//  ExpertUISwift
//
//  Created by piyush sinroja on 25/04/18.
//  Copyright © 2018 piyush. All rights reserved.
//

import UIKit

public enum Iphone: CGFloat {
    case iPhone4 = 480
    case iPhone5 = 568
    case iPhone8 = 667
    case iPhone8Plus = 736
    case iPhoneX = 812
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

public class PixelHelper: NSObject {
    public static let objPixelHelper = PixelHelper()
    public static var defaultScreenWidth: CGFloat = DefaultTookWidthPixels.iPhone8Plus.rawValue   // In pixel
    public static var defaultScreenHeight: CGFloat = DefaultTookHeightPixels.iPhone8Plus.rawValue  // In pixel
    
    // For Iphone 5 and 6,7,8 Set TwoX, for Iphone 6+,7+,8+, 10 set Threex
    public var pixelMulti: CGFloat = DefaultTwoXOrThreeX.threeXScreen.rawValue

    /// DefaultTwoXOrThreeX
    ///
    /// - twoXScreen: 2x screen like (640 * 1136), (750 * 1334)
    /// - threeXScreen: 3x screen like (1242 * 2208), (1125 * 2436)
    public enum DefaultTwoXOrThreeX: CGFloat {
        case twoXScreen = 2, threeXScreen
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
        for constraint in constr where constraint.constant != 0 {
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
    public class func setFontForDeviceFrom(obj: [AnyObject], isSetStaticSize: Bool = false) {
        for objClass in obj {
            switch objClass {
            case is UILabel:
                if isSetStaticSize {
                    (objClass as? UILabel)?.setFontForDevice(fontName: nil, isSetStaticSize: isSetStaticSize)
                } else {
                    (objClass as? UILabel)?.setFontForDevice(fontName: nil, sizeofFont: nil)
                }
            case is UIButton:
                if isSetStaticSize {
                    (objClass as? UIButton)?.setFontForDevice(fontName: nil, isSetStaticSize: isSetStaticSize)
                } else {
                    (objClass as? UIButton)?.setFontForDevice(fontName: nil, sizeofFont: nil)
                }
            case is UITextField:
                if isSetStaticSize {
                    (objClass as? UITextField)?.setFontForDevice(fontName: nil, isSetStaticSize: isSetStaticSize)
                } else {
                    (objClass as? UITextField)?.setFontForDevice(fontName: nil, sizeofFont: nil)
                }
            case is UITextView:
                if isSetStaticSize {
                    (objClass as? UITextView)?.setFontForDevice(fontName: nil, isSetStaticSize: isSetStaticSize)
                } else {
                    (objClass as? UITextView)?.setFontForDevice(fontName: nil, sizeofFont: nil)
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
        case Iphone.iPhone4.rawValue, Iphone.iPhone5.rawValue:
            self = (constrInPixel * DefaultTookWidthPixels.iPhone5.rawValue)/PixelHelper.defaultScreenWidth
            self /= 2
        //Iphone 8
        case Iphone.iPhone8.rawValue:
            self = (constrInPixel * DefaultTookWidthPixels.iPhone8.rawValue)/PixelHelper.defaultScreenWidth
            self /= 2
        //Iphone 8plus
        case Iphone.iPhone8Plus.rawValue:
            self = (constrInPixel * DefaultTookWidthPixels.iPhone8Plus.rawValue)/PixelHelper.defaultScreenWidth
            self /= 3
        //Iphone X
        case Iphone.iPhoneX.rawValue:
            self = (constrInPixel * DefaultTookWidthPixels.iPhoneX.rawValue)/PixelHelper.defaultScreenWidth
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
        case Iphone.iPhone4.rawValue:
            self = (constrInPixel * 960)/PixelHelper.defaultScreenHeight
            self /= 2
        //Iphone 5
        case Iphone.iPhone5.rawValue:
            self = (constrInPixel * DefaultTookHeightPixels.iPhone5.rawValue)/PixelHelper.defaultScreenHeight
            self /= 2
        //Iphone 8
        case Iphone.iPhone8.rawValue:
            self = (constrInPixel * DefaultTookHeightPixels.iPhone8.rawValue)/PixelHelper.defaultScreenHeight
            self /= 2
        //Iphone 8plus
        case Iphone.iPhone8Plus.rawValue:
            self = (constrInPixel * DefaultTookHeightPixels.iPhone8Plus.rawValue)/PixelHelper.defaultScreenHeight
            self /= 3
        //Iphone X
        case Iphone.iPhoneX.rawValue:
            self = (constrInPixel * DefaultTookHeightPixels.iPhoneX.rawValue)/PixelHelper.defaultScreenHeight
            self /= 3
        default:
            self = constrInPixel
        }
        print(self)
        return self
    }
    
    fileprivate mutating func newSizeFont() -> CGFloat {
        let screenheight = UIScreen.main.bounds.size.height
        var changeValue = self
        
        switch (PixelHelper.defaultScreenHeight, screenheight) {
        // iphone5, iphone8
        case (DefaultTookHeightPixels.iPhone5.rawValue, Iphone.iPhone8.rawValue):
           changeValue += 2
        // iphone5, iPhone8Plus
        case (DefaultTookHeightPixels.iPhone5.rawValue, Iphone.iPhone8Plus.rawValue):
            changeValue += 3
        // iphone5, iPhoneX
        case (DefaultTookHeightPixels.iPhone5.rawValue, Iphone.iPhoneX.rawValue):
            changeValue += 2
        
        // iPhone8, iPhone5
        case (DefaultTookHeightPixels.iPhone8.rawValue, Iphone.iPhone5.rawValue):
            changeValue -= 2
        //iphone8, iPhone4
        case (DefaultTookHeightPixels.iPhone8.rawValue, Iphone.iPhone4.rawValue):
            changeValue -= 2
        //iphone8, iPhone8Plus
        case (DefaultTookHeightPixels.iPhone8.rawValue, Iphone.iPhone8Plus.rawValue):
            changeValue += 1
        
        //iPhone8Plus, iPhone4
        case (DefaultTookHeightPixels.iPhone8Plus.rawValue, Iphone.iPhone4.rawValue):
            changeValue -= 3
        //iPhone8Plus, iPhone5
        case (DefaultTookHeightPixels.iPhone8Plus.rawValue, Iphone.iPhone5.rawValue):
            changeValue -= 3
        //iPhone8Plus, iPhone8
        case (DefaultTookHeightPixels.iPhone8Plus.rawValue, Iphone.iPhone8.rawValue):
            changeValue -= 1
        //iPhone8Plus, iPhoneX
        case (DefaultTookHeightPixels.iPhone8Plus.rawValue, Iphone.iPhoneX.rawValue):
            changeValue -= 1
            
        //iPhoneX, iPhone4
        case (DefaultTookHeightPixels.iPhoneX.rawValue, Iphone.iPhone4.rawValue):
            changeValue -= 2
        //iPhoneX, iPhone5
        case (DefaultTookHeightPixels.iPhoneX.rawValue, Iphone.iPhone5.rawValue):
            changeValue -= 2
        //iPhoneX, iPhone8Plus
        case (DefaultTookHeightPixels.iPhoneX.rawValue, Iphone.iPhone8Plus.rawValue):
            changeValue += 1
            
        default:
            print("")
        }
        
        return changeValue
    }
}
// MARK: - UILabel Extension
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
    
    public func setFontForDevice(fontName: String?, isSetStaticSize: Bool = false) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if isSetStaticSize {
            fontSize = fontSize.newSizeFont()
        }
        self.font = UIFont(name: nameOfFont!, size: fontSize)!
    }
}
// MARK: - UIButton Extension
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
    
    public func setFontForDevice(fontName: String?, isSetStaticSize: Bool = false) {
        var nameOfFont = self.titleLabel?.font.fontName
        var fontSize: CGFloat = (self.titleLabel?.font.pointSize)!
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if isSetStaticSize {
            fontSize = fontSize.newSizeFont()
        }
        self.titleLabel?.font = UIFont(name: nameOfFont!, size: fontSize)!
    }
}
// MARK: - UITextField Extension
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
    
    public func setFontForDevice(fontName: String?, isSetStaticSize: Bool = false) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if isSetStaticSize {
            fontSize = fontSize.newSizeFont()
        }
        self.font = UIFont(name: nameOfFont!, size: fontSize)!
    }
}
// MARK: - UITextView Extension
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
    
    public func setFontForDevice(fontName: String?, isSetStaticSize: Bool = false) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if isSetStaticSize {
            fontSize = fontSize.newSizeFont()
        }
        self.font = UIFont(name: nameOfFont!, size: fontSize)!
    }
}
