//
//  Files+CoreDataProperties.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 28.06.2023.
//
//

import Foundation
import CoreData

@objc(Files)
public class Files: NSManagedObject {}

extension Files {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Files> {
        return NSFetchRequest<Files>(entityName: "Files")
    }
    
    @NSManaged public var name: String
    @NSManaged public var data: Data?
    @NSManaged public var type: String
    @NSManaged public var date: Date
    @NSManaged public var size: Int16
    @NSManaged public var id: Int16
    
}

extension Files : Identifiable {}
