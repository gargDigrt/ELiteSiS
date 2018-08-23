//
//  WebServices.swift
//  EliteSISSwift
//
//  Created by Vivek on 12/08/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Alamofire
import SwiftyJSON


class WebServices: NSObject {
    
    
    static var shared = WebServices()
    
    let baseURL = "http://43.224.136.81:5015/"
    let schoolId = "/MBLE_APP_00001"
    let contactID = "65e99ee3-7669-e811-8157-c4346bdc1f11"
//    let schoolID = UserDefaults.standard.string(forKey: "Name")
    
    var headers : [String: String] {
        var dict = [String: String]()
        dict["UserName"] = "MobileApp"
        dict["Pwd"] = "7b3639a4ab39765739a5e0ed75bc8016"
        return dict
    }
    
    // For Login
    func loginUserWith(username: String, password: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
      
        let requestURL = baseURL + "SIS_Student/Login/" + username + "/" + password + schoolId
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
        
    }
    
    
    // To get user profile
    func getProfile(forRegistrationID rID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetProfile/" + rID + schoolId
        
        
        Alamofire.request(requestURL, headers: headers).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
    }
    
    //To get user dashboard
    func getDashboardDetailsFor(classSession: String, studentId: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetDashboardData/" + classSession + "/" + studentId + schoolId
        
        Alamofire.request(requestURL, headers: headers).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
        
    }
    
    
    // for menu list
    func menuListItem(role: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
        let requestURL = baseURL + "SIS/GetConfigurations/" + role + schoolId

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    // for Discussion API
    func getLessionPlansFor(classSession: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
        
        let requestURL = baseURL + "SIS_Student/GetLessonPlan/" + classSession + schoolId
        print(
        )
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
   

    // For getting Faculty List
    
    func getFacultyList(sectionID: String,  completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
        
        let requestURL = baseURL + "SIS/getFacultyList/" + sectionID + schoolId

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    // For discussion API get Chat
    func getChatMessage(senderID: String, RecipientId: String, CreatedOn: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )  {
        
        let requestURL = baseURL + "SIS_Student/GetChat/" + senderID + "/" + RecipientId + "/" + CreatedOn + schoolId

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    
    // For discussion API get Chat
    func sendNewMessage(text: String,senderID: String, RecipientId: String, completion: @escaping (_ success: Bool, _ error:Error? ) -> Void )  {
        
        let requestURL = baseURL + "SIS_Student/CreateDiscussion/MBLE_APP_00001"
        
//        let sender = "/contacts(\(senderID))"
        let params = ["new_Sender@odata.bind": "/contacts(\(senderID))",
            "new_Recipient@odata.bind": "/contacts(\(RecipientId))",
            "new_message": text]
        
//        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(requestURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
           if let statusCode = responseData.response?.statusCode {
            if statusCode == 200 {
                completion(true, nil)
            }else{
                completion(false, nil)
            }
            } else {
                completion(false, responseData.error)
            }
        }
    }
    
    // for showing holidayList
    func getHolidayList(completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/Holidays/MBLE_APP_00001"

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    // for showing Assignment
    func getAssignmentList(studentID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetAssignmentList/" + studentID + schoolId
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    // To download assignment
    func downloadAssignment(objectID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/DownloadAssignment/" + objectID + schoolId

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    
    // Get address for the user
    func getAddress(forRegistrationID rID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetAddress/" + rID + schoolId
        
        Alamofire.request(requestURL, headers: headers).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
    }
    
    // Get Id card detail
    func getID(forRegistrationID rID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetID/" + rID + "/MBLE_APP_00001"
        
        Alamofire.request(requestURL, headers: headers).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                //                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
    }
    
    
    //To get states for country id
    func getStates(forCountryID cID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetState/" + cID + schoolId
        
        Alamofire.request(requestURL, headers: headers).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
    }
    
    //To get cities for state id
    func getCities(forStateID sID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetCity/" + sID + schoolId
        
        Alamofire.request(requestURL, headers: headers).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            }else{
                completion(nil, responseData.error)
            }
        }
    }
    
    //To get attendence status
    func getAttendenceStatusFor(studentID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        let requestURL = baseURL + "SIS_Student/GetStudentAttendance/" + studentID + schoolId
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    // To get notification list
    func getNotificationFor(contactID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetNotificationList/" + contactID + schoolId

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    
    // get performanc list
    func getPerformancelistFor(studentID: String, sessionID: String, sectionID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/getPerformanceList/" + studentID + "/" + sessionID + "/" + sectionID + "/" + schoolId

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    
    // To Get Study Progress
    func getStudyProgress(marksID: String, completion:@escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
       
        let requestURL = baseURL + "SIS_Student/GetStudyProgress/" + marksID + schoolId

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    // get TIME TABLE
    func getTimeTableFor(sessionID: String, sectionID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void ) {
        
        let requestURL = baseURL + "SIS_Student/GetTimeTable/"  + sessionID + "/" + sectionID + "/" + schoolId

        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
//                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    func getPhotoAlbums(completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void  ){
        
        let requestURL = baseURL + "SIS_Student/GetGalleryFolders/MBLE_APP_00001"
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                //                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
    
    func getImagesForAlbum(withId id: String,completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void  ){
        
        let requestURL = baseURL + "SIS_Student/GetImages/" + id + schoolId
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!, headers: headers).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value {
                let responseDict = JSON(result)
                //                debugPrint(responseDict)
                completion(responseDict, nil)
            } else {
                completion(nil, responseData.error)
            }
        }
    }
}
