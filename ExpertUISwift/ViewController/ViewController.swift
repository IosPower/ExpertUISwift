//
//  ViewController.swift
//  ExpertUISwift
//
//  Created by piyush sinroja on 25/04/18.
//  Copyright © 2018 piyush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // UILabel Outlets
    @IBOutlet weak var lblHeadingName: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblEmailId: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    
    // UITextField Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtBirthday: UITextField!
    @IBOutlet weak var txtMale: UITextField!
    
    // UIView Outlets
    @IBOutlet weak var viewMain: UIView!
    
    // NSLayoutConstraint Outlets
    @IBOutlet var constrMix: [NSLayoutConstraint]!
    
    // UIView Outlets
    @IBOutlet weak var viewDetails: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // use method 1 or method 2
        
        // setupUI()
        getAllViewsAndSetLayout()
    }
    
    // MARK: - Method 1
    /// setupLayout with all constraint outlets
    func setupUI() {
        viewDetails.layer.cornerRadius = 3
        viewDetails.shadownew(value: 5.0)
        
        // This Public Method is Used For Automatic set Constraints According To Device screen Size
        PixelHelper.setConstraintAutomatic(constr: constrMix)
        
        // This Public Method is Used For Automatic set Font Size According To Device screen Size
        PixelHelper.setFontForDeviceFrom(obj: [lblHeadingName, lblname, lblEmailId, lblMobile, lblBirthday, lblGender, txtName, txtEmail, txtMobile, txtBirthday, txtMale])
        
        //1) Custom Font Set fontDefaultIphone6 in Appdelegate , and give result According To  Device.
        //2) 35 set for Iphone6plus
        
        //  lblL.setFontForDevice(fontName: "HelveticaNeue-UltraLight", sizeofFont: 35)
    }
    
    // MARK: - Method 2
    /// getAllViewsAndSetLayout
    func getAllViewsAndSetLayout() {
        var arrViews: [UIView] = []
        //subviews From
        func subviewsFrom(view: UIView) {
            arrViews.append(view)
            for view in view.subviews {
                subviewsFrom(view: view)
            }
        }
        
        subviewsFrom(view: viewMain)
        
        for viewCheckinh in arrViews {
            // This Public Method is Used For Automatic set Constraints According To Device screen Size
            PixelHelper.setConstraintAutomatic(constr: viewCheckinh.constraints)
        }
        
        let arrFilter = arrViews.filter({$0 is UILabel || $0 is UITextView || $0 is UITextField || $0 is UIButton})
        // This Public Method is Used For Automatic set Font Size According To Device screen Size
        
        PixelHelper.setFontForDeviceFrom(obj: arrFilter)
       //PixelHelper.setFontForDeviceFrom(obj: arrFilter, isSetStaticSize: true)
    }
    
    // MARK: - Button Action
    @IBAction func btnNext(_ sender: Any) {
    }
}

// MARK: - UIView Extension
extension UIView {
    func shadownew(value: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = value
    }
    
    func shadownew() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
    }
}
