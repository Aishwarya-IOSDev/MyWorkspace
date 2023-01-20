//
//  ViewController.swift
//  RxSpace
//
//  Created by Aishwarya Aneja on 1/20/23.
//

import UIKit

class ViewController: UIViewController {
    
    let headerTitles = ["Company", "Launches"]
    
    var getInfo :Information?
    
    var launch_arr = [Launch]()
    
    @IBOutlet weak var tblw :UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCompanyInfoApi()
        getLaunchApi()
    }
    
    
    func getCompanyInfoApi(){
        let url = "https://api.spacexdata.com/v4/company"
                       
               SKApiManager.getAPI(url, parameters: [:]) { (result, error) in
                   
                   if error == nil{
                   
                   let resultDict = result as! NSDictionary
                   
                       
                       let decoder = JSONDecoder()
                       
                       do {
                           let data = try JSONSerialization.data(withJSONObject: resultDict, options: [])
                           
                           if let stringJSON = String(data: data, encoding: .utf8) {
                               print("Search Dict =", stringJSON)
                           }
                           self.getInfo = try decoder.decode(Information.self, from: data)
                           
                           DispatchQueue.main.async {
                               print("Get information =", self.getInfo)
                                self.tblw.reloadData()
                           }
                       } catch {
                           print("Error converting dict to data with Code:", error)
                       }
                   
                   }
                   else{
                    print(error)
                   }
                  
               }
               
           }
    
    
    func getLaunchApi(){
        let url = "https://api.spacexdata.com/v4/launches"
                       
               SKApiManager.getAPI(url, parameters: [:]) { (result, error) in
                   
                   if error == nil{
                   
                   let resultDict = result as! NSArray
                   
                       
                       let decoder = JSONDecoder()
                       
                       do {
                           let data = try JSONSerialization.data(withJSONObject: resultDict, options: [])
                           
                           if let stringJSON = String(data: data, encoding: .utf8) {
                               print("Search Dict =", stringJSON)
                           }
                           self.launch_arr = try decoder.decode([Launch].self, from: data)
                           
                           DispatchQueue.main.async {
                               print("Get information =", self.launch_arr.count)
                                self.tblw.reloadData()
                           }
                       } catch {
                           print("Error converting dict to data with Code:", error)
                       }
                   
                   }
                   else{
                    print(error)
                   }
                  
               }
               
           }
    
    @IBAction func onClickFilter(_ sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        self.present(vc, animated: true)
    }

}

