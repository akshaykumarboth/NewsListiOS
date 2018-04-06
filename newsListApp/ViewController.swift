//
//  ViewController.swift
//  newsListApp
//
//  Created by cbzuser on 05/04/18.
//  Copyright © 2018 cbzuser. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var news: Array<New> = []
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDataFromApi();
        
        tableview.dataSource = self;
        tableview.delegate = self;
        
        
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 140
    }
    
    func getDataFromApi() {
        do{
            DispatchQueue.global(qos: .userInteractive).async {
                let loginResponse = Util.makeHttpCall(url: "http://m.cricbuzz.com/interview/newslist", method: "GET", param: [:])
                DispatchQueue.main.async {
                    if loginResponse.contains("") {
                        //self.errorLabel.text = "Username does not exists"
                        //self.errorLabel.isHidden = false
                    }  else {
                        let rootObject = Root(JSONString: loginResponse)
                        print(rootObject.news?.count)
                        self.news = rootObject.news!
                        self.tableview.reloadData()
                        
                    }
                }
            }
            
            
        }catch let error as NSError {
            print(" Error \(error)")
        }
        
    }

   
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCell
        
        cell.myCellLabel.text = news[indexPath.row].headline?.trimmingCharacters(in: .whitespacesAndNewlines)
        print(news[indexPath.row].image)
        guard let url = news[indexPath.row].image else{
            return cell
        }
        //Util.loadImageAsync(url: url, imgView: cell.myImage)
        cell.myImage.imageFromServerURL(urlString: url)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        print(news[indexPath.row].id as Any)
    }
    
    
    
}

