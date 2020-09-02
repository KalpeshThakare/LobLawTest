//
//  NetworkHelper.swift
//  LoblawTest
//
//  Created by Kalpesh Thakare on 2020-09-02.
//  Copyright © 2020 Kalpesh Thakare. All rights reserved.
//

import UIKit
import SDWebImage

class NetworkHelper {

    static let sharedInstance = NetworkHelper()

    func getDataFromUrl(url: String, SuccessBlock: @escaping (Data) -> Void, FailureMessage:@escaping (String) -> Void) -> Void {

       let task = URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in
           if(error == nil && data != nil) {
            SuccessBlock(data!)
           } else {
            FailureMessage(error?.localizedDescription ?? "Error fetching Data")
           }
       })

       task.resume()
    }

}
