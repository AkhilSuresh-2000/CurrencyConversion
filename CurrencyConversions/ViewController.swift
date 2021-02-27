//
//  ViewController.swift
//  CurrencyConversions
//
//  Created by Akhil Suresh on 2021-02-19.
//

import UIKit

class ViewController: UIViewController {
    
    //Declaring variables
    var currencyValue:[Double] = []
    var baseCurrency: [String] = []
    var currentbaseCurrency: Double = 0
    
    
    @IBOutlet weak var txtCurrency: UITextField!
    
    @IBOutlet weak var PcikerView: UIPickerView!
    
    
    @IBOutlet weak var labelREsult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PcikerView.delegate = self
        PcikerView.dataSource = self
        self.PcikerView.reloadAllComponents()
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=7472912d65c81e0161c7d81c755d2876")
        
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if(error != nil){
                print("Error")
            }
            else{
                
                if let correctData = data{
                    //ParseData
                    do{
                        let myCurrencyData = try JSONSerialization.jsonObject(with: correctData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myCurrencyData["rates"] as? NSDictionary{
                            
                            for(key,value) in rates{
                                self.baseCurrency.append(key as! String)
                                self.currencyValue.append(value as! Double)
                                
                            }
                            print(self.baseCurrency)
                            print(self.currentbaseCurrency)
                        }
                    }
                    catch{
                        print("error \(error.localizedDescription)")
                    }
                    
                    
                }
            }
           
            
        }.resume()
        
    }

    
   
    

    
    @IBAction func btnConvert(_ sender: Any) {
        
        if(txtCurrency.text != ""){
            labelREsult.text = String(Double(txtCurrency.text!)! * currentbaseCurrency)
        }
    }

}




extension ViewController: UIPickerViewDelegate , UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return baseCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return baseCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentbaseCurrency = currencyValue[row]
        
        //if it doesen't show the data run it again
    }
    
    
    
}

