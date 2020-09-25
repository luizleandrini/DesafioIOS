//
//  ViewController+CoreData.swift
//  projetoIOS
//
//  Created by Luiz Guilherme on 23/09/20.
//  Copyright © 2020 Luiz Guilherme. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController{
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
