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
    
    // NSLayoutConstraint Outlets
    @IBOutlet var constrMix: [NSLayoutConstraint]!
    
    // UIView Outlets
    @IBOutlet weak var viewDetails: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
   
    // MARK: - SetupUI
    func setupUI() {
        viewDetails.layer.cornerRadius = 3
        viewDetails.shadownew(value: 5.0)
        
        // This Public Method is Used For Automatic set Constraints According To Device screen Size
        PixelHelper.setConstraintAutomatic(constr: constrMix)
        
        // This Public Method is Used For Automatic set Font Size According To Device screen Size
        PixelHelper.setFontForDevice(obj: [lblHeadingName, lblname, lblEmailId, lblMobile, lblBirthday, lblGender, txtName, txtEmail, txtMobile, txtBirthday, txtMale])
        
        //1) Custom Font Set fontDefaultIphone6 in Appdelegate , and give result According To  Device.
        //2) 35 set for Iphone6plus
        
        //  lblL.setFontForDevice(fontName: "HelveticaNeue-UltraLight", sizeofFont: 35)
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
