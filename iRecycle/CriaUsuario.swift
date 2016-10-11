//
//  CriaUsuario.swift
//  iRecycle
//
//  Created by Ronan on 8/30/16.
//  Copyright © 2016 RONAN. All rights reserved.
//

import UIKit

class CriaUsuario: UIViewController {

    @IBOutlet weak var Usuario: UITextField!
    @IBOutlet weak var Senha1: UITextField!
    @IBOutlet weak var Senha2: UITextField!
    var criaUsuario: RestController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // funcao para exibir uma mensagem de alerta
    func showMessage(title: String, message: String){
        
        let dialog = UIAlertController(title: title,message: message,preferredStyle: UIAlertControllerStyle.Alert)
        
        dialog.addAction(UIAlertAction(title:"Ok", style: .Default, handler: nil))
        
        presentViewController(dialog, animated: true, completion: nil)
    }
    //---------------------------------------------
    
    
    @IBAction func criaLogin(sender: AnyObject) {
        
        
        
        if Usuario.hasText() && Senha1.hasText() && Senha2.hasText() {
            
            if Senha1.text == Senha2.text {
                //showMessage("Resultado", message:"Usuário: \(Usuario.text!), \(Senha1.text!) ")
                criaUsuario = RestController()
                
                criaUsuario.restCriaLogin("user=\(Usuario.text!)&pass=\(Senha1.text!)")
                
                Usuario.text = ""
                Senha1.text = ""
                Senha2.text = ""
                
            } else {
                showMessage("ERRO", message: "Senhas diferente")
            }
            
        } else{
            showMessage("ERRO", message: "Preencha todos os campos")
        }
        
    
   
    }

    @IBAction func escondeTeclado(sender: AnyObject) {
        
        Senha2.resignFirstResponder()
        
    }
        
    

}
