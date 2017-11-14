//
//  FirstViewController.swift
//  News Venezuela
//
//  Created by Andres Calvo on 9/30/17.
//  Copyright © 2017 Andres Calvo. All rights reserved.
//

import UIKit
//import SwiftyXMLParser

//extension String {
//    func toJSON() -> Any? {
//        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
//        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//    }
//}

class FirstViewController: UIViewController, NSURLConnectionDelegate, XMLParserDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var request = URLRequest(url: URL(string: "http://eltiempo.com.ve/venezuela/feed/")!)


        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }

            let responseString = String(data: data, encoding: .utf8)

            if let index = responseString?.index(of: "<item>") {
                let domains = responseString?.suffix(from: index)
                let splitValues = domains?.components(separatedBy: "</item>")
                var local = splitValues
                local?.remove(at: (splitValues?.count)!-1)
                
                for string in local! {
                    print(string + "\n</item>")
                    print()
                    print()
                    print("--------------------------------------------------------------------------------------------------------------------------------------------------------")
                }
                //print(splitValues!)  // "ab\n"
            }
            //print(responseString!)

//            let json: AnyObject? = responseString?.toJSON() as AnyObject
//            print("Parsed JSON: \(json!)")
//            let xml = XMLParser.init(data: data)
//            print(xml)

        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
