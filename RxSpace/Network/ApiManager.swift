//
//  ApiManager.swift
//  RxSpace
//
//  Created by Aishwarya Aneja on 1/20/23.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

//MARK : - SVProgressHUD
import Foundation
import UIKit
import Alamofire
import SVProgressHUD








//Api Listing
struct apiHelper
{
  
    static let users = "users"
    
    

}

typealias SKApiManagerHandler = ((_ result:Any?, _ Error:Error?) -> Void)?

//MARK : - API
class SKApiManager: NSObject
{
    static let shared = SKApiManager()
}

extension SKApiManager
{
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private func printAPI_Before(strURL:String = "", parameters:[String:Any] = [:], headers:[String:String] = [:])
    {
        var str = "\(parameters)"
        str = str.replacingOccurrences(of: " = ", with: ":")
        str = str.replacingOccurrences(of: "\"", with: "")
        str = str.replacingOccurrences(of: ";", with: "")
        
           print("APi - \(strURL)\nParameters - \(str)\nHeaders - \(headers)")
    }
    
    private func printAPI_After(response:DataResponse<Any>)
       {
           //        return
           //        print("request: \(response.request)")  // original URL request
           //        print("response: \(response.response)")  // URL response
           //        print("data: \(response.data)") // server data
           
           if let value = response.result.value
           {
               //  print("result.value: \(value)") // result of response serialization
           }
           if let error = response.result.error
           {
               print("result.error: \(error)") // result of response serialization
           }
       }

    
    
    
    private func hitAPI(_ apiURl:String = "",
                        type:HTTPMethod = .get,
                        parameters:[String:Any] = [:],
                        headers:[String:String] = [:],
                        completionHandler: SKApiManagerHandler)
    {
        var strURL:String = apiURl
//
        
        
        

                
        
        SKApiManager.shared.printAPI_Before(strURL: strURL, parameters: parameters, headers: [:])
        
        
        let api =  Alamofire.request(
            strURL,
            method: type,
            parameters: parameters,
            encoding: URLEncoding.httpBody,
            headers: [:])
        
        
        api.responseJSON {
            response -> Void in
            
            
            SKApiManager.shared.printAPI_After(response: response)
            //Profile successfully updated
            if let JSON = response.result.value
            {
                completionHandler!(JSON as Any?, nil)
            }
            else if let ERROR = response.result.error
            {
                completionHandler!(nil, ERROR as Error?)
            }
            else
            {
                completionHandler!(nil, NSError(domain: "error", code: 117, userInfo: nil))
            }
        }
    }
    
    
 
    
    
      class func getAPI(_ apiURl:String = "",
                      parameters:[String:Any] = [:],
                      headers:[String:String] = [:],
                      completionHandler: SKApiManagerHandler
        )
    {
        
        if (SKApiManager.isConnectedToInternet()) {
            SKApiManager.shared.hitAPI(
                apiURl,
                type: .get,
                parameters: parameters,
                headers: headers,
                completionHandler: completionHandler
            )
        } else {

            
            print("Check your Internet connection")
        }
    }
   
    
}
