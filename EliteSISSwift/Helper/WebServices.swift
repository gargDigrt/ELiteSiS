//
//  WebServices.swift
//  EliteSISSwift
//
//  Created by Vivek on 12/08/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import SwiftHash
import Alamofire
import SwiftyJSON


class WebServices: NSObject {
    
    
    static var shared = WebServices()
    
    let baseURL = "http://43.224.136.81:5015/"
    
    
    func loginUserWith(username: String, password: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        
        let md5EncodedPassword = MD5(password)
        
        let requestURL = baseURL + "SIS_Student/Login/" + username + "/" + md5EncodedPassword + "/MBLE_APP_00001"

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
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
    
    
    func getProfile(forRegistrationID rID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetProfile/" + rID + "/MBLE_APP_00001"
//        let encodedURL = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
    }
    
    func getDashboardDetailsFor(classSession: String, studentId: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetDashboardData/" + classSession + "/" + studentId + "/MBLE_APP_00001"
        
        Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
        
    }
    
    
    // for menu list
    func MenuListItem(role: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
        let stringMenuList = baseURL + "SIS/GetConfigurations/" + role + "/MBLE_APP_00001"
        print(stringMenuList)
        let encodedURL = stringMenuList.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    // for Discussion API
    func ChooseTeacherForDiscussion(classSession: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
        let stringMenuList = baseURL + "SIS_Student/GetLessonPlan/" + classSession + "/MBLE_APP_00001"
        print(stringMenuList)
        let encodedURL = stringMenuList.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
    }
}
    
    // for showing holidayList
    func showHolidayList(completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        let stringMenuList = baseURL + "SIS_Student/Holidays/MBLE_APP_00001"
        print(stringMenuList)
        let encodedURL = stringMenuList.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    // for showing Assignment
    func showAssignmentList(studentID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        let stringMenuList = baseURL + "SIS_Student/GetAssignmentList/" + studentID + "/MBLE_APP_00001"
        print(stringMenuList)
        let encodedURL = stringMenuList.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
}
