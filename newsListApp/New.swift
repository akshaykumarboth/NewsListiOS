//
//  New.swift
//  newsListApp
//
//  Created by cbzuser on 05/04/18.
//  Copyright © 2018 cbzuser. All rights reserved.
//

import Foundation

class New {
    
    var id : String?
    var headline :String?
    var timestamp :Date?
    var location :String?
    var image :String?
    
    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = (json["id"] as? String)
            //print("skill id is ",self.id! )
        }
        
        if json["headline"] != nil {
            self.headline = json["headline"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["location"] != nil {
            self.location = json["location"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["image"] != nil {
            self.image = json["image"] as? String
            print(" image is ",self.image! )
        }
        
        if json["timestamp"] != nil {
            //self.startDate =
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            self.timestamp = dateFormatter.date(from: (json["timestamp"] as? String!)!)
            //print("skill id is ",self.id! )
        }
    
    }
    
    
}
