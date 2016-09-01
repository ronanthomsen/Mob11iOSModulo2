//
//  AppDelegate.swift
//  LeitorQRCode
//
//  Created by Ronan on 8/21/16.
//  Copyright © 2016 RONAN. All rights reserved.
//


import UIKit
import AVFoundation

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
    //@IBOutlet weak var showCancelButtonSwitch: UISwitch!
    @IBOutlet weak var lbRestResult: UILabel!
    
    @IBAction func scanAction(sender: AnyObject) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            let reader = createReader()
            reader.modalPresentationStyle = .FormSheet
            reader.delegate               = self
            
            reader.completionBlock = { (result: QRCodeReaderResult?) in
                if let result = result {
                    print("Completion with result: \(result.value) of type \(result.metadataType)")
                }
            }
            
            presentViewController(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true) { [weak self] in
            let alert = UIAlertController(
                title: "QRCodeReader",
                message: String (format:"%@ (of type %@)", result.value, result.metadataType),
                preferredStyle: .Alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            self?.presentViewController(alert, animated: true, completion: nil)
        }
        
        
         UIApplication.sharedApplication().openURL(NSURL(string: "\(result.value)")!)
        
        postDataToURL(result.value)
        
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func createReader() -> QRCodeReaderViewController {
        let builder = QRCodeViewControllerBuilder { builder in
            builder.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
            builder.showTorchButton = true
            builder.showCancelButton = true
            //self.showCancelButtonSwitch.on
        }
        
        return QRCodeReaderViewController(builder: builder)
    }
    
    
    func postDataToURL(qrcode: String) {
        
        // Setup the session to make REST POST call
        // o padrao para a passagem da msg sera peso_fiap_usuario_userId_timestemp
        //resposta true ou false _ peso -> true_pesoAtual_pesoTotal
        
        //let postEndpoint: String = "http://localhost:8080/IRecycle/validaQRCode?id=\(qrcode)"
        let postEndpoint: String = "http://172.16.70.79:8080/IRecycle/validaQRCode?id=\(qrcode)"
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
            print("SAIU AQUI \(responseString!)")
            
            self.performSelectorOnMainThread("updatePostLabel:", withObject: String(responseString!), waitUntilDone: false)
        }
        task.resume()
    }
    
    //MARK: - Methods to update the UI immediately
    func updatePostLabel(text: String) {
        self.lbRestResult.text = "POST : " + text
    }

    
    
}
