//
//  Comment.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright © 2020 Mar Koss. All rights reserved.
//

import Foundation
import Firebase

class Comment: NSObject
{
    var body = String()
    var timeStamp : String
    var userID = String()
    var username = String()
    var commentID = String()
    
    init(body: String)
    {
        let date = Date()
        let dateForm = DateFormatter()
        dateForm.dateFormat = "MM-dd-yyyy HH:mm:ss"
        let dateStr = dateForm.string(from: date)
        
        self.body = body
        self.timeStamp = dateStr
        self.userID = ""
        self.commentID = ""
        self.username = ""
    }
}
