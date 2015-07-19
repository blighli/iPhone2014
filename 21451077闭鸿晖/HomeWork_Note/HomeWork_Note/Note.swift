//
//  Note.swift
//  HomeWork_Note
//
//  Created by turbobhh on 11/22/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

import Foundation
import CoreData

@objc(Note)
class Note: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var photos: NSData
    @NSManaged var content: String

}
