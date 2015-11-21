//
//  ViewController.swift
//  AccesarServiciosNube1
//
//  Created by Carlos Brito on 20/11/15.
//  Copyright © 2015 Carlos Brito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var actionClear: UIButton!
    @IBOutlet weak var isbn: UITextField!
    @IBOutlet weak var respuesta: UITextView!
    @IBOutlet weak var errorLabel: UILabel!
    var texto : String = ""
    
    @IBAction func actionClear(sender: AnyObject) {
        self.isbn.text = ""
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        isbn.resignFirstResponder()
        
        getISBNInfo(textField.text!)
        
        
        
        return true
        
    }
    
    func getISBNInfo(isbn: String) -> Void {
        self.errorLabel.text = ""
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + self.isbn.text!
        
        NSLog("url:  "+urls)
        
        let url = NSURL (string: urls)
        let sessions = NSURLSession.sharedSession()
        
        let bloque = {(datos:NSData?, response: NSURLResponse?, error:NSError?) -> Void in
          let res = response as? NSHTTPURLResponse
        
            if res?.statusCode == 200 {
                NSLog("Ok")
                let texto2 = NSString (data: datos!, encoding: NSUTF8StringEncoding)
                self.texto = String(texto2)
                NSLog(self.texto)
                if (self.texto == "Optional({})"){
                    self.texto = "Error, no se encontró el libro"
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.respuesta.text = self.texto
                })
                
            }else
                if res?.statusCode >= 400 {
                    NSLog("4xx error")
                    
            }
            
        }
        
        let dt = sessions.dataTaskWithURL(url!, completionHandler: bloque)
        dt.resume()

        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isbn.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func sincrono(){
        let urls = "http://dia.ccm.itesm.mx/"
        let url = NSURL(string: urls)
        let datos : NSData? = NSData (contentsOfURL: url!)
        let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        print(texto!)
        
    }
    
    func asincrono(){
        let urls = "http://dia.ccm.itesm.mx"
        let url = NSURL(string: urls)
        let session = NSURLSession.sharedSession()
        
        let bloque =  {(datos:NSData?, resp : NSURLResponse?, error: NSError?) -> Void in
            let texto = NSString (data:datos!, encoding: NSUTF8StringEncoding)
            print(texto)
            
        }
        
        let dt = session.dataTaskWithURL(url!, completionHandler: bloque)
        
        dt.resume()
        print("antes o despues?")
    }
    

}

