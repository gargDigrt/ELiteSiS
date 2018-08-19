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
    let contactID = "65e99ee3-7669-e811-8157-c4346bdc1f11"
    let schoolID = UserDefaults.standard.string(forKey: "Name")
    
    
    // For Login
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
    
    
    // To get user profile
    func getProfile(forRegistrationID rID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetProfile/" + rID + "/MBLE_APP_00001"
        
        
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
    
    //To get user dashboard
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
    func menuListItem(role: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
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
    func getLessionPlansFor(classSession: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
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
   

    // For getting Faculty List
    
    func getFacultyList(sectionID: String,  completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
        let stringMenuList = baseURL + "SIS/getFacultyList/" + sectionID + "/MBLE_APP_00001"
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
    
    // For discussion API get Chat
    func getChatMessage(senderID: String, RecipientId: String, CreatedOn: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
        let stringMenuList = baseURL + "SIS_Student/GetChat/" + senderID + "/" + RecipientId + "/" + CreatedOn + "/MBLE_APP_00001"
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
    func getHolidayList(completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
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
    func getAssignmentList(studentID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
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
    
    // To download assignment
    func downloadAssignment(objectID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        let stringMenuList = baseURL + "SIS_Student/DownloadAssignment/" + objectID + "/MBLE_APP_00001"
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
    
    
    // Get address for the user
    
    func getAddress(forRegistrationID rID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetAddress/" + rID + "/MBLE_APP_00001"
        
        
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
    
    //To get states for country id
    func getStates(forCountryID cID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetState/" + cID + "/MBLE_APP_00001"
        
        
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
    
    //To get cities for state id
    func getCities(forStateID sID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetCity/" + sID + "/MBLE_APP_00001"
        
        
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
    
    //To get attendence status
    func getAttendenceStatusFor(studentID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        let stringMenuList = baseURL + "SIS_Student/GetStudentAttendance/" + studentID + "/MBLE_APP_00001"
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
    
    // To get notification list
    func getNotificationFor(contactID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let stringMenuList = baseURL + "SIS_Student/GetNotificationList/" + contactID + "/MBLE_APP_00001"
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
    
    
    // get performanc list
    
    func getPerformancelistFor(studentID: String, sessionID: String, sectionID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let stringMenuList = baseURL + "SIS_Student/getPerformanceList/" + studentID + "/" + sessionID + "/" + sectionID + "/" + "/MBLE_APP_00001"
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
    
    
    // To Get Study Progress
    
    func getStudyProgress(marksID: String, completion:@escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
       
        let stringMenuList = baseURL + "SIS_Student/GetStudyProgress/" + marksID + "/MBLE_APP_00001"
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
    
    // get TIME TABLE
    
    func getTimeTableFor(sessionID: String, sectionID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let stringMenuList = baseURL + "SIS_Student/GetTimeTable/"  + sessionID + "/" + sectionID + "/" + "/MBLE_APP_00001"
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
