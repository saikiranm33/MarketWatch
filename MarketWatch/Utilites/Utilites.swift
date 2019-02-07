//
//  Utilites.swift
//  SwiftyProject
//
//  Created by Nunc on 14/11/18.
//  Copyright © 2018 NUNC. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIColor {
    convenience init?(hexRGBA: String?) {
        guard let rgba = hexRGBA, let val = Int(rgba.replacingOccurrences(of: "#", with: ""), radix: 16) else {
            return nil
        }
        self.init(red: CGFloat((val >> 24) & 0xff) / 255.0, green: CGFloat((val >> 16) & 0xff) / 255.0, blue: CGFloat((val >> 8) & 0xff) / 255.0, alpha: CGFloat(val & 0xff) / 255.0)
    }
    convenience init?(hexRGB: String?) {
        guard let rgb = hexRGB else {
            return nil
        }
        self.init(hexRGBA: rgb + "ff") // Add alpha = 1.0
    }
}

extension UIView {
    
    func addDashedLine(color: UIColor?) {
        layer.sublayers?.filter({ $0.name == "DashedTopLine" }).map({ $0.removeFromSuperlayer() })
        backgroundColor = .clear
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedTopLine"
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color!.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4, 4]
        
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
        
        
        
    }
}

class Utilites {
    
    static let shared:Utilites = {
        
       return Utilites()
        
    }()

    func SaveOrdersInCoreData(InputDic :NSDictionary)
    {
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Orders", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
     
        newUser.setValue(InputDic["name"], forKey: "name")
        newUser.setValue(InputDic["quantity"], forKey: "quantity")
        newUser.setValue(InputDic["price"], forKey: "price")
        newUser.setValue(InputDic["orderType"], forKey: "orderType")
        newUser.setValue(InputDic["exchange"], forKey: "exchange")
        

        
        do {
            
            try context.save()
            
        } catch {
            
            print("Failed saving")
        }
        
      
    }
    
    func FetchOrdersFromCoreData() -> NSMutableArray
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var resultArray = NSMutableArray()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        

        
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                var  reqDict = [String:Any]()
                
                 reqDict["name"] = data.value(forKey: "name")
                 reqDict["price"] = data.value(forKey: "price")
                 reqDict["exchange"] = data.value(forKey: "exchange")
                 reqDict["orderType"] = data.value(forKey: "orderType")
                 reqDict["quantity"] = data.value(forKey: "quantity")

//                print(data.value(forKey: "name") as! String)
                resultArray.add(reqDict)
            }
            
            
        } catch {
            
            print("Failed")
        }
        
        
        


        

        
       return resultArray
        
    }
    
    
    
    func showAlertWithOneBtn(alertTitle : NSString, alertMessage : NSString,OKActionHandler: @escaping () -> Void)
    {

        let alertController = UIAlertController(title: alertTitle as String, message: alertMessage as String, preferredStyle:.alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
        
        
            OKActionHandler()
            

        }
        
        
        alertController.addAction(alertAction)

  UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    func showAlertWithTwoBtn(alertTitle : NSString, alertMessage : NSString,button1Title :NSString,button2Title : NSString,button1ActionHandler: @escaping () -> Void,button2ActionHandler: @escaping () -> Void)
    {

        let alertController = UIAlertController(title: alertTitle as String, message: alertMessage as String, preferredStyle:.alert)
        
        let button1Action = UIAlertAction(title: button1Title as String, style: .default) { (UIAlertAction) in
            
            button1ActionHandler()
            
        }
        
        let button2Action = UIAlertAction(title: button2Title as String, style: .default) { (UIAlertAction) in
            
            button2ActionHandler()
            
        }
        
        
        alertController.addAction(button1Action)
        alertController.addAction(button2Action)
  
      UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
 
    }
    
    
    func bottomLineForTextFiled(txtFilled :UITextField)
    {

        let bottomLine = CALayer()

        bottomLine.frame  =  CGRect(x: 0, y: txtFilled.frame.height - 1, width: UIScreen.main.bounds.width, height: 1.0)

        
        bottomLine.backgroundColor = UIColor.init(hexRGB: BottomLineColorForFiled)?.cgColor
        
        txtFilled.borderStyle = UITextField.BorderStyle.none
        
        txtFilled.clipsToBounds = true
        
        txtFilled.layer.addSublayer(bottomLine)

    }
    
    

    
    func textFieldsLeftIconDesign(txtFilled : UITextField,imgName :NSString)
    {
        
        let containerVw = UIView()
        
        containerVw.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        
        containerVw.backgroundColor = UIColor.clear
        
        let leftImage = UIImageView()
  
        leftImage.image = UIImage(named: imgName as String)
        
        leftImage.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        
        containerVw.addSubview(leftImage)
        
        txtFilled.leftView = containerVw
        
        txtFilled.leftViewMode = .always
        
    }
    

    func string(text : NSString,pattern : NSString) -> Bool
    {
        
        let regExpression = try? NSRegularExpression(pattern: pattern as String, options: []);
        
        let matches =  regExpression?.numberOfMatches(in: text as String, options: [], range: NSMakeRange(0, text.length))
        
        return matches ?? 0 > 0
        
    }
    
    
    
    func getAppScreenSize() -> CGSize
    {
        
        let  screenSize:CGSize = UIScreen.main.bounds.size
        

        return CGSize.init(width: screenSize.height, height: screenSize.width)
        
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func CheckValidEmail(strText : NSString) -> Bool
    {
        
        let regex:NSString = "[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"
        
        var isEmpty:Bool = false
        
        if self.string(text: strText, pattern: regex)
        {
            
            isEmpty = true
        }
        
        return isEmpty
        
        
    }
    
    
    func CheckValidMobile(strText : NSString) -> Bool
    {
    
       let numericOnly = NSCharacterSet.decimalDigits;
        
        let myStringSet = NSCharacterSet(charactersIn: strText as String)
        
        var isEmpty:Bool = false;
        
        if(strText.length == 10 && numericOnly .isSuperset(of: myStringSet as CharacterSet) && strText.substring(to: 1) == "5" && strText.substring(to: 1) == "6" && strText.substring(to: 1) == "7" && strText.substring(to: 1) == "8" && strText.substring(to: 1) == "9")
        {
 
            isEmpty = true;
            
        }
 
        return isEmpty;
      
    }
    
    
  
    func ConvertDateFormate(inputDate:NSString,inputDataFormat:NSString,outputDateFormat:NSString) -> NSString
    {

        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = inputDataFormat as String

        let date:Date? = dateFormatter.date(from: inputDate as String)
 
        dateFormatter.dateFormat = outputDateFormat as String
        
        let convertedDateString:NSString? = dateFormatter.string(from: date!) as NSString

        return convertedDateString!
        
    }
    
   
    
    func checkTextFieldsLength(textFieldsArray:NSArray) -> UITextField
    {
        
        var textfield = UITextField()
        
        for i in textFieldsArray
        {
            
           textfield  = textFieldsArray[i as! Int] as! UITextField
            
            
            if textfield.text?.count == 0
            {
                
                
                return textfield;
            }
            
            
            
        }
        
        return textfield;
    }
    
    
    
    func CheckValidpassword(pwrd:NSString) -> Bool
    {
        var isValid = true;
        
        
        if pwrd.length < 8
        {
            
            isValid = false;
        }
        
        
        return isValid;
    }
    
   
    
    func getTodayDate(dateFormatter:DateFormatter) -> Date
    {
        
        let today = Date()
        
        
        return today
        
    }
    
}
