//
//  ControleQRCode.swift
//  iRecycle
//
//  Created by Ronan on 8/30/16.
//  Copyright © 2016 RONAN. All rights reserved.
//

import UIKit
import AVFoundation

class ControleQRCode: UIViewController, QRCodeReaderViewControllerDelegate {

    var idUsuarioAtual:String?
    var pesoAtual: String?
    var somaPeso: Float = 0
    var validador: String = "fiap"
    var timeStampAtual: String?
    var timeStamptAntigo:String?=""
    
    
    //var timeStamp: String?
    
    
    
    @IBOutlet weak var lbPeso: UILabel! //variavel que irá exibir o peso retornado do servidor
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pesoAtual != "" {
            
            lbPeso.text = pesoAtual
            
        }else{
            
            lbPeso.text = "0"
        }
        
        
        
    }
    
    
    
    @IBAction func lerQRCode(sender: AnyObject) {
        
        if QRCodeReader.supportsMetadataObjectTypes() {
            let reader = createReader()
            reader.modalPresentationStyle = .FormSheet
            reader.delegate               = self
            
            reader.completionBlock = { (result: QRCodeReaderResult?) in
                if let result = result {
                    print("Completion with result: \(result.value) of type \(result.metadataType)")
                    
                    
                    var separaQRCode = result.value.componentsSeparatedByString("_")
                    self.timeStampAtual = separaQRCode[2]
                    print("\(self.timeStampAtual!)")
                    
                    
                    
                    //print("\()")
                    
                    var temp = Float(self.pesoAtual!)
                    self.somaPeso = self.somaPeso + temp!
                    let temp2 = Float(separaQRCode[0])
                    temp = (Float(separaQRCode[0]))!*0.1
                    self.somaPeso = (self.somaPeso + temp!)
                    self.pesoAtual = String(self.somaPeso)
                    
       
                    
                    if self.timeStampAtual != self.timeStamptAntigo {
                        
                        let chamadaRest: RestController = RestController()
                        chamadaRest.atualizaPeso("\(String(temp2!))_\(self.validador)_\(self.idUsuarioAtual!)")
                        self.timeStamptAntigo = self.timeStampAtual!
                        self.lbPeso.text = "\(self.pesoAtual!)"
                        
                    }                    
                    
                    self.somaPeso = 0
                }
            }
            
            presentViewController(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "ERRO", message: "Leitor não suportado pelo aparelho", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //QRCodeReader metodos do Delegate
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true) { [weak self] in
            
        }
        
    }
    
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func createReader() -> QRCodeReaderViewController {
        let builder = QRCodeViewControllerBuilder { builder in
            builder.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
            builder.showTorchButton = true // exibe o botão de cancelar
        }
        
        return QRCodeReaderViewController(builder: builder)
    }
    @IBAction func limpaNSUser(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("vLogin")
        
    }
    
    func showMessage(title: String, message: String){
        
        let dialog = UIAlertController(title: title,message: message,preferredStyle: UIAlertControllerStyle.Alert)
        
        dialog.addAction(UIAlertAction(title:"Ok", style: .Default, handler: nil))
        
        presentViewController(dialog, animated: true, completion: nil)
    }
    
}







