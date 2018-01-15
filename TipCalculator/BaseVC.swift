//
//  BaseVC.swift
//
//
//  Created by Ashish Mittal  on 28/09/17.
//  Copyright © 2017 Ashish Mittal . All rights reserved.
//

import Foundation
import UIKit

class BaseVC:UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func addTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BaseVC.tapped(tap:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func tapped(tap: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
//    func addLoader() {
//        removeLoader()
//        UIApplication.shared.beginIgnoringInteractionEvents()
//        UIApplication.shared.delegate?.window??.addSubview(Utilities.loaderView)
//    }
    
//    func removeLoader() {
//        if UIApplication.shared.isIgnoringInteractionEvents{
//            UIApplication.shared.endIgnoringInteractionEvents()
//        }
//        Utilities.loaderView.removeFromSuperview()
//    }
    
}
