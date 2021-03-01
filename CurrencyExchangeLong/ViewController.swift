//
//  ViewController.swift
//  CurrencyExchangeLong
//
//  Created by english on 2021-02-19.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentCurrency = myValues[row]
        
    }
    
    //OBJECTS:
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var txtInput: UITextField!
    @IBAction func btnExchange(_ sender: UIButton) {
        if(txtInput.text != ""){
            lblResult.text = String(Double(txtInput.text!)! * currentCurrency)
        }
        
    }
    @IBOutlet weak var lblResult: UILabel!
    
    //create variables
    var currentCurrency: Double = 0
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    //viewDidLoad
    
    override func viewDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource = self
        super.viewDidLoad()
        //identify the URL
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=56d6ea66dd6f6bf7b525503070ed4dcc&form")
        //open the URL in browser in background
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            //check if there are errors
            if error != nil{
                print("Error")
            }
            //if there is not any error, proceed to parsing
            else{
                //check if the content is correct
                if let content = data{
                    do{
                        //parsing
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key,value) in rates{
                                self.myCurrency.append(key as! String)
                                self.myValues.append(value as! Double)
                            }
                            print(self.myCurrency)
                            print(self.myValues)
                        }
                    }catch{
                        print("error")
                    }
                }
            }
            self.pickerView.reloadAllComponents()
        }
        task.resume()
    }


}

