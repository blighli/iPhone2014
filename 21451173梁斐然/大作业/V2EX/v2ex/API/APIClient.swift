//
//  APIClient.swift
//  v2ex
//
//  Created by LFR on 14-10-16.
//  Copyright (c) 2014年 FR. All rights reserved.
//

import UIKit
import Alamofire

let APIRootURL = "http://www.v2ex.com/api/"

class APIClient {
   
    class var sharedInstance : APIClient {
        struct Static {
            static let instance : APIClient = APIClient()
        }
        return Static.instance
    }
    
    func getJSONData(path: NSString, parameters: [String : AnyObject]?, success: (JSON) -> Void, failure: (NSError) -> Void) {
        Alamofire.request(.GET, APIRootURL + path, parameters: parameters)
            .responseSwiftyJSON { (request, response, json, error) in
                if let err = error? {
                    failure(err)
                } else {
                    success(json)
                }
        }
    }
    
    func getLatestTopics(success: (JSON) -> Void, failure: (NSError) -> Void) {
        self.getJSONData("topics/hot.json", parameters: nil, success: success, failure: failure)
    }
    
    func getLatestTopics(nodeID: NSString, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["node_id": nodeID]
        self.getJSONData("topics/show.json", parameters: dict, success: success, failure: failure)
    }
    
    func getReplies(topicID: NSString, success: (JSON) -> Void, failure: (NSError) -> Void) {
        let dict = ["topic_id": topicID]
        self.getJSONData("replies/show.json", parameters: dict, success: success, failure: failure)
    }
    
    func getNodes(success: (JSON) -> Void, failure: (NSError) -> Void) {
        self.getJSONData("nodes/all.json", parameters: nil, success: success, failure: failure)
    }

}
