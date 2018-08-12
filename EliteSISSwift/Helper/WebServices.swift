//
//  WebServices.swift
//  EliteSISSwift
//
//  Created by Vivek on 12/08/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import SwiftHash
import Alamofire
import SwiftyJSON


class WebServices: NSObject {
    
    
    static var shared = WebServices()
    
    let baseURL = "http://43.224.136.81:5015/"
    
    
    func loginUserWith(username: String, password: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        
        let md5EncodedPassword = MD5(password)
        
        let stringLoginCall = baseURL + "SIS_Student/Login/" + username + "/" + md5EncodedPassword + "/MBLE_APP_00001"

        let encodedURL = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
        
        
    }
    
    
    
    
    
    
}
