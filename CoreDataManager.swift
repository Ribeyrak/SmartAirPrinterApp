//
//  CoreDataManager.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 28.06.2023.
//

import CoreData
import UIKit

// MARK: - CRUD
public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createFile(name: String, data: Data) {
        guard let fileEntityDescription = NSEntityDescription.entity(forEntityName: "Files", in: context) else { return }
        let file = Files(entity: fileEntityDescription, insertInto: context)
        file.name = name
        file.data = data
        
        appDelegate.saveContext()
    }
    
    public func fetchFiles() -> [Files] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
        do {
            return (try? context.fetch(fetchRequest) as? [Files]) ?? []
        }
    }
    
    public func fetchFile(with id: Int16) -> Files? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let photos = try? context.fetch(fetchRequest) as? [Files]
            return photos?.first
        }
    }
    
    public func updateFile(with id: Int16, newUrl: String, title: String? = nil) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard let files = try? context.fetch(fetchRequest) as? [Files],
                  let file = files.first else { return }
            file.name = title
        }
        appDelegate.saveContext()
    }
    
    public func deleteAllFiles() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
        do {
            let photos = try? context.fetch(fetchRequest) as? [Files]
            photos?.forEach{ context.delete($0) }
        }
        appDelegate.saveContext()
    }
    
    public func deleteFile(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Files],
                  let photo = photos.first else { return }
            context.delete(photo)
        }
        appDelegate.saveContext()
    }
}
