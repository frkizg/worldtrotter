//
//  ConversionViewController.swift
//  Worldtrotter
//
//  Created by Zvonimir Grebenar on 21/04/16.
//  Copyright © 2016 Zvonimir Grebenar. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Conversion view did load")
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        print(hour)
        if hour < 7 || hour > 21 {
            view.backgroundColor = UIColor.blackColor()
        }
        
    }
    var farenheitValue: Double? {
        didSet{
            updateCelsiuLabel()
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func dismissKeyboard (sender: AnyObject){
        textField.resignFirstResponder()
    }
    
    var celsiusValue: Double?{
        if let value = farenheitValue{
            
            return (value - 32) * (5/9)
        }
        else{
            return nil
        }
    }
    
    
    @IBAction func fahrenheitFieldEditingChanged(textFiled: UITextField){
    
        if let text = textField.text, value = Double (text){
            farenheitValue = value
        }
        else{
            farenheitValue = nil
        }
    }
    
    func updateCelsiuLabel(){
        if let value = celsiusValue{
        
            celsiusLabel.text = nummberFormatter.stringFromNumber(value)
        }
        else{
            celsiusLabel.text = "???"
        }
    }
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
       
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replecementTextHasDecimalSeparator = string.rangeOfString(".")
        
        let allowedChars = NSCharacterSet.init(charactersInString: "0123456789,.")
        let replacementText = NSCharacterSet.init(charactersInString: string)
        
        //let replecemetTextHasAlphabeticChars = string.rangeOfString(NSRange()
        
        if existingTextHasDecimalSeparator != nil && replecementTextHasDecimalSeparator != nil {
            return false
        }
        if !allowedChars.isSupersetOfSet(replacementText){
            print("Unallowed character: \(string)")
            return false
        }
        else{
            return true
        }
    }
    
    let nummberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    
}
