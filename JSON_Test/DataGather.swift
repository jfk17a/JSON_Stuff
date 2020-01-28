//
//  DataGather.swift
//  JSON_Test
//
//  Created by Joshua Kersker on 1/28/20.
//  Copyright © 2020 Joshua Kersker. All rights reserved.
//

import UIKit

class DataGather: NSObject {
    
    let MYJSONURL = "https://api.myjson.com/bins/136w0u"
    
        var dataArray = ["No Data"]
    
        func getData(completion: @escaping (_ success: Bool) -> ()){
            var success = true
            
            let actualUrl = URL(string: MYJSONURL)
            
            let task = URLSession.shared.dataTask(with: actualUrl!){
                (data, responce, error) in
                
                guard let _ = data, error == nil else {
                    // we had an error or the data didn't come back
                    success = false
                    return
                }
                
                
                /********* NEW GOODNESS**********/
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    //printing the json in console
                    print(jsonObj.value(forKey: "characters")!)
                    
                    //getting the characters tag array from json and converting it to NSArray
                    if let veggieArray = jsonObj.value(forKey: "characters") as? Array<String> {
                        self.dataArray = veggieArray
                    }
                }
                
                //call back to the completion handler that was passed in, notifying to do things (we don't care what)
                completion(success)
            }
            task.resume()
        }
    }
