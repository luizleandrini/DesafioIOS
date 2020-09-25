//
//  CadastroViewController.swift
//  projetoIOS
//
//  Created by Luiz Guilherme on 22/09/20.
//  Copyright © 2020 Luiz Guilherme. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfFone: UITextField!
    @IBOutlet weak var tfCPF: UITextField!
    @IBOutlet weak var dpNasc: UIDatePicker!
    @IBOutlet weak var tfSexo: UITextField!
    
    var cadastro: Cadastro!
    lazy var pickerView: UIPickerView = {
       let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if cadastro != nil{
            title = "Editar Cliente"
            tfName.text = cadastro.name
            tfFone.text = cadastro.fone
            tfCPF.text = cadastro.cpf
            if let datanasc = cadastro.datanasc{
                dpNasc.date = datanasc
            }
        }
        prepareCadastroTextField()
    }
    
    func prepareCadastroTextField(){
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolBar.tintColor = UIColor(named: "main")
        
        //let btCancelar = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelar))
        let btOk = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ok))
        toolBar.items = [btOk]
        
        pickerData = ["Masculino", "Feminino"]
        tfSexo.inputView = pickerView
        tfSexo.inputAccessoryView = toolBar
    }
    
    @objc func cancelar(){
        tfSexo.resignFirstResponder()
    }
    @objc func ok(){
        cancelar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //-------------------------------
    }
    

    @IBAction func btSalvar(_ sender: UIButton) {
        
        if cadastro == nil{
            cadastro = Cadastro(context: context)
        }
        cadastro.name = tfName.text
        cadastro.datanasc = dpNasc.date
        cadastro.cpf = tfCPF.text
        cadastro.fone = tfFone.text
        if tfName.text == "" || tfCPF.text == "" || tfFone.text == "" || tfSexo.text == "" {
            showToast(message: "Todos campos devem estar preenchidos!")
        }else{
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
            showToast(message: "Cliente cadastrado!")
            navigationController?.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CadastroViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfSexo.text = pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
}

extension UIViewController{
    func showToast(message: String){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let toastLbl = UILabel()
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.font = UIFont.systemFont(ofSize: 18)
        toastLbl.textColor = UIColor.white
        toastLbl.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLbl.numberOfLines = 0
        
        let textSize = toastLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        toastLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth, height: textSize.height)
        toastLbl.center.x = window.center.x
        toastLbl.layer.cornerRadius = 10
        toastLbl.layer.masksToBounds = true
        
        window.addSubview(toastLbl)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLbl.alpha = 0
        }) { (_) in
            toastLbl.removeFromSuperview()
        }
    }
}
