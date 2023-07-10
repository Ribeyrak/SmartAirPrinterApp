//
//  CoreDataManager.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 28.06.2023.
//

import CoreData
import UIKit
import UniformTypeIdentifiers
import CoreServices


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
    
    public func createFile(name: String, data: Data, type: String) {
        guard let fileEntityDescription = NSEntityDescription.entity(forEntityName: "Files", in: context) else { return }
        let file = Files(entity: fileEntityDescription, insertInto: context)
        file.name = name
        file.data = data
        if #available(iOS 14.0, *) {
            file.type = getFileType(from: data)
        } else {
            // Fallback on earlier versions
        }
        file.date = Date()
        
        appDelegate.saveContext()
    }
    
    public func fetchFiles() -> [Files] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return (try? context.fetch(fetchRequest) as? [Files]) ?? []
        }
    }
    
    @available(iOS 14.0, *)
    private func getFileType(from data: Data) -> String {
        let temporaryFileName = UUID().uuidString
        let temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(temporaryFileName)
        
        do {
            try data.write(to: temporaryURL)
            let utType = try UTType(filenameExtension: temporaryURL.pathExtension)
            try FileManager.default.removeItem(at: temporaryURL)
            
            return utType?.preferredMIMEType ?? "Unknown"
        } catch {
            print("Error: \(error)")
            return "Unknown"
        }
    }
    
    public func getFileSize(file: Files) -> Int64? {
        guard let data = file.data else {
            return nil
        }
        return Int64(data.count)
    }
    
    public func fetchFile(with id: Int16) -> Files? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let photos = try? context.fetch(fetchRequest) as? [Files]
            return photos?.first
        }
    }
    
    public func updateFile(with id: Int16, newUrl: String, title: String) {
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
    
    public func deleteFile(with name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Files],
                  let photo = photos.first else { return }
            context.delete(photo)
        }
        appDelegate.saveContext()
    }
}
