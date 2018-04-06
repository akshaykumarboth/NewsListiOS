//
//  Util.swift
//  newsListApp
//
//  Created by cbzuser on 05/04/18.
//  Copyright © 2018 cbzuser. All rights reserved.
//

import Foundation
import UIKit

class Util{
    
    static func makeHttpCall (url : String, method: String, param: [String:String]) -> String {
        print(url)
        var success = "aa"
        let semaphore = DispatchSemaphore(value: 0)
        guard let urll = URL(string: url) else {
            return "Error"
        }
        
        var request = URLRequest(url: urll)
        //var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        //
        if (request.httpMethod  == "POST" || request.httpMethod == "PUT") {
            //let postString = "{ \"name\":\"John\", \"age\":30, \"car\":null }"
            if request.httpMethod == "PUT" {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type") //Optional
                //request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
            var postString = ""
            if param.isEmpty == false {
                for (key, value) in param {
                    postString = postString + "\(key)" + "=" + "\(value)" + "&"
                    
                }
            }
            print("herp \(postString)")
            request.httpBody = postString.data(using: .utf8)
        }
        URLSession.shared.dataTask(with:request, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                success = String(data: data, encoding: String.Encoding.utf8)!
                semaphore.signal()
            } catch let error as NSError {
                print(" error \(error)")
            }
        }).resume()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return success
        
    }
    
    static func loadImageAsync(url: String, imgView: UIImageView){
        
        if let urlObject = URL(string: url) {
            DispatchQueue.global().async {
                do {
                    let data = try? Data(contentsOf: urlObject) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    
                    DispatchQueue.main.async {
                        if data != nil {
                            imgView.image = UIImage(data: data!)
                        } else {
                            imgView.image = UIImage(named: "q")
                        }
                    }
                }catch let error as NSError {
                    print(" Error \(error)")
                }
                
            }
        }
        
    }
    
    

}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

