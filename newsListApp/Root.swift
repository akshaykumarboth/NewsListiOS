//
//  Root.swift
//  newsListApp
//
//  Created by cbzuser on 05/04/18.
//  Copyright © 2018 cbzuser. All rights reserved.
//

import Foundation

class Root {
   
    var detailed_URL : String?
    var news : Array<New>?
    
    init (JSONString: String) {
        do{
            
            let json = try JSONSerialization.jsonObject(with: JSONString.data(using: .utf8)!, options: .allowFragments) as! [String:Any]
            if json != nil {
                
                if json["detailed_URL"] != nil {
                    self.detailed_URL = json["detailed_URL"] as? String
                }
                
                if json["news"] != nil {
                    var list2: Array<New> = []
                    for item in json["news"] as! NSArray {
                        list2.append(New(json: item as! [String:Any]))
                    }
                    self.news = list2
                }
                
               
                
            }
            
        }catch let error as NSError {
            print(" Error \(error)")
        }
        
    }
}
