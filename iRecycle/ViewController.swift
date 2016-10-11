//
//  ViewController.swift
//  iRecycle
//
//  Created by Ronan on 8/30/16.
//  Copyright © 2016 RONAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    var defautSession:NSUserDefaults!
    var pesoAtual:String?
    var idUsuarioAtual: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "loginEfetuado"{
            let loginOk = segue.destinationViewController as! ControleQRCode
            loginOk.idUsuarioAtual = self.idUsuarioAtual
            loginOk.pesoAtual = self.pesoAtual
        }
        
    }
    
// funcao para exibir uma mensagem de alerta
    func showMessage(title: String, message: String){
        
        let dialog = UIAlertController(title: title,message: message,preferredStyle: UIAlertControllerStyle.Alert)
        
        dialog.addAction(UIAlertAction(title:"Ok", style: .Default, handler: nil))
        
        presentViewController(dialog, animated: true, completion: nil)
   }
//---------------------------------------------
    
//função para validar se o login digitado é o mesmo obtido pelo servidor
    func validaLogin(){
    
        let chamadaRest: RestController = RestController()
        let usuario_senha: String = "user="+String(txtUsuario.text!)+"&pass="+String(txtSenha.text!)
        chamadaRest.restValidaLogin(usuario_senha)
        
    }
//---------------------------------------------
    
//função acionada pelo botão entrar
    
    @IBAction func btValidaLogin(sender: AnyObject) {

        
        var retornoLogin: String = String()
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        if txtUsuario.hasText() && txtSenha.hasText(){
            validaLogin()
            sleep(10)
            
            if let login = defaults.stringForKey("vLogin") {
                
                print("\(login) LOGIN")
                var temp = login.componentsSeparatedByString("_")
                retornoLogin = temp[0]
                print("\(retornoLogin) Retorno Login")
                idUsuarioAtual = temp[1]
                pesoAtual = temp[2]
                
                print("Valor Retorno Login: \(retornoLogin)")
            }else{
                retornoLogin = "false"
            }
            
            
            if retornoLogin == "true" {
                //defautSession.removeObjectForKey("vLogin")
                self.performSegueWithIdentifier("loginEfetuado", sender: self)
            }else{
                    showMessage("ERRO", message: "Usuário ou Senha incorretos")
            }
            
            
        }else{
            showMessage("ERRO", message: "Preencha todos os campos")
        }
        
        
    }
    
//---------------------------------------------

}

