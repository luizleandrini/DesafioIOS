//
//  ClientesTableViewCell.swift
//  projetoIOS
//
//  Created by Luiz Guilherme on 22/09/20.
//  Copyright © 2020 Luiz Guilherme. All rights reserved.
//

import UIKit

class ClientesTableViewCell: UITableViewCell {
    @IBOutlet weak var lbDescript: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func age(datanasc: Date) -> Double {
//        var ageComponents: DateComponents = Calendar.current.dateComponents([.year], from: datanasc, to: Date())
//        print(ageComponents)
//        return Double(ageComponents.year!)
//        
//    }
    func prepare(with cadastro: Cadastro){
        //lbDescript.text = cadastro.name
        
        print(cadastro.name!)
    }
    
}
