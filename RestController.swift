//
//  RestController.swift
//  iRecycle
//
//  Created by Ronan on 8/31/16.
//  Copyright © 2016 RONAN. All rights reserved.
//

import UIKit

class RestController: UIViewController {

    //let urlLogin = "http://172.16.70.104:8080/IRecycle/validaQRCode?id="
    let urlLogin = "http://172.16.70.113:8080/IRecycle/Login?"
    let urlAtualisaPeso = "http://172.16.70.113:8080/IRecycle/validaQRCode?id="
    var defautSession:NSUserDefaults!
    var retorno: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.defautSession = NSUserDefaults.standardUserDefaults()
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func restValidaLogin(usuario_senha: String) {

        print("\(usuario_senha)")
        
        let postEndpoint: String = urlLogin+"\(usuario_senha)"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        //let postParams : [String: AnyObject] = ["id": "teste"]
        
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        // Make the POST call and handle it in a completion handler
        let task = session.dataTaskWithRequest(request){
            data, response, error in
            if error != nil{
                print("ERROR \(error)")
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding )
            
            self.performSelectorOnMainThread(#selector(RestController.validaRetornoLogin(_:)), withObject: String(responseString!), waitUntilDone: false)
            
            
        }
        task.resume()
    }
    
    //MARK: - Methods to update the UI immediately
    func validaRetornoLogin(retornoLogin: String){
        
        print("Valor Retorno Servidor: \(retornoLogin)")
        
        var temp = retornoLogin.componentsSeparatedByString("_")
        
        if temp[0] == "true" {

            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(retornoLogin, forKey: "vLogin")

        }
        
        
    }
    
    //função para gravar no servidor 
    func atualizaPeso(pesoAtual: String) {
        
        print("\(pesoAtual)")
        
        let postEndpoint: String = urlAtualisaPeso+"\(pesoAtual)"
        print("\(postEndpoint)")
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        //let postParams : [String: AnyObject] = ["id": "teste"]
        
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        // Make the POST call and handle it in a completion handler
        let task = session.dataTaskWithRequest(request){
            data, response, error in
            if error != nil{
                print("ERROR \(error)")
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding )
            
            self.performSelectorOnMainThread(#selector(RestController.validaRetornoPeso(_:)), withObject: String(responseString!), waitUntilDone: false)
            
            
        }
        task.resume()
    }
    func validaRetornoPeso(confimServer: String){
        print("\(confimServer) RESPOSTA SERVER")
        
    }
    
 

}
