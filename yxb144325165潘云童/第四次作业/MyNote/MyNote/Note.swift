//
//  Note.swift
//  MyNote
//
//  Created by Joker on 14/11/22.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

import Foundation
import CoreData

class Note: NSManagedObject {

    @NSManaged var image: String
    @NSManaged var text: String
    @NSManaged var time: String

}
