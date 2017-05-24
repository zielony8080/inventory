//
//  AlertController.swift
//  mInventory
//
//  Created by Łukasz Zielony on 08.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import UIKit


class AlertController {
    
    class func info(title: String, message: String, inController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        inController.present(alertController, animated: true, completion: nil)
    }
    
}
