//
//  ExitViewController.swift
//  projetoIOS
//
//  Created by Luiz Guilherme on 25/09/20.
//  Copyright © 2020 Luiz Guilherme. All rights reserved.
//

import UIKit

class ExitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btSair(_ sender: UIButton) {
        exit(0)
    }
    
}
