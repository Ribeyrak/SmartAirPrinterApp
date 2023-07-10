//
//  FilesController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 15.06.2023.
//

import UIKit
import AVFoundation
import MobileCoreServices

protocol FilesControllerDelegate: AnyObject {
    func didTapOpenICloud()
    func didTapOpenGallery()
}

class FilesController: BaseController, UIPrintInteractionControllerDelegate {
    
    //MARK: - Properties
    private var files: [[Files]] = []
    var vc = PrinterController()
    weak var delegate: FilesControllerDelegate?
    var selectedPhoto: UIImage?
    
    // MARK: - UI
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    //MARK: - Navigations
    override func navBarLeftButtonHandler() {
        print("Files left button tapped")
    }
    
    override func navBarRightButtonHandler() {
        print("Files right button tapped")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch files from CoreData
        let allFiles = CoreDataManager.shared.fetchFiles()
        
        // Group files by date
        let groupedFiles = Dictionary(grouping: allFiles) { file -> Date in
            // Here you should return the date portion of the file's date property
            return Calendar.current.startOfDay(for: file.date)
        }
        files = groupedFiles.sorted { $0.key < $1.key }.map { $0.value }
        
        tableView.reloadData()
    }
}

// MARK: - Extension
extension FilesController {
    override func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(15)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        // setup navifations
        title = R.Strings.NavBar.files
        //let dollarButton = UIBarButtonItem(image: R.Images.Common.dollarButton,  style: .plain, target: self, action: #selector(didTapDollarButton))
        //let squadeButton = UIBarButtonItem(image: R.Images.Common.squadeButton,  style: .plain, target: self, action: #selector(didTapSquadeButton))
        //navigationItem.leftBarButtonItems = [dollarButton, squadeButton]
        //navigationItem.leftBarButtonItem = squadeButton
        
        let listButton = UIBarButtonItem(image: R.Images.Common.listButton,  style: .plain, target: self, action: #selector(didTapListButton))
        navigationItem.leftBarButtonItem = listButton
        let plusButton = UIBarButtonItem(image: R.Images.Common.plusButton,  style: .plain, target: self, action: #selector(didTapPlusButton))
        //navigationItem.rightBarButtonItems = [plusButton, listButton]
        navigationItem.rightBarButtonItem = plusButton
        
        // setup table
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilesCell")
    }
    
    // MARK: - Actions
    @objc func didTapDollarButton(sender: AnyObject) {
//        let nextVC = ViewController()
//        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func didTapSquadeButton(sender: AnyObject) {
    }
    
    @objc func didTapListButton(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortByDateAction = UIAlertAction(title: "Sort by Date", style: .default) { [weak self] _ in
            self?.sortFilesByDate()
        }
        let sortBySizeAction = UIAlertAction(title: "Sort by Size", style: .default) { [weak self] _ in
            self?.sortFilesBySize()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(sortByDateAction)
        alertController.addAction(sortBySizeAction)
        alertController.addAction(cancelAction)

        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = (sender as AnyObject).bounds
        }

        present(alertController, animated: true, completion: nil)
    }
    func sortFilesByDate() {
        files = files.sorted { $0[0].date < $1[0].date }
        tableView.reloadData()
    }
    func sortFilesBySize() {
        for sectionIndex in 0..<files.count {
            let sortedSection = files[sectionIndex].sorted { file1, file2 in
                let fileSize1 = CoreDataManager.shared.getFileSize(file: file1) ?? 0
                let fileSize2 = CoreDataManager.shared.getFileSize(file: file2) ?? 0
                return fileSize1 < fileSize2
            }
            files[sectionIndex] = sortedSection
        }
        tableView.reloadData()
    }
    func getTotalFileSize(for fileSection: [Files]) -> Int64 {
        var totalSize: Int64 = 0
        for file in fileSection {
            if let fileSize = CoreDataManager.shared.getFileSize(file: file) {
                totalSize += fileSize
            }
        }
        return totalSize
    }
    
    @objc func didTapPlusButton(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let importFilesAction = UIAlertAction(title: "Import from Files", style: .default) { [self] _ in
            // Handle "Импорт из файлов" action
            //self.delegate?.didTapOpenICloud()
            openICloud()
        }
        let importPhotosAction = UIAlertAction(title: "Import from Photos", style: .default) { [self] _ in
            // Handle "Импорт из фотографий" action
            // ...
            openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(importFilesAction)
        alertController.addAction(importPhotosAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = (sender as AnyObject).bounds
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func presentPrintController(with image: UIImage) {
        let printController = UIPrintInteractionController.shared
        printController.delegate = self
        
        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .photo
        printInfo.jobName = "Scan"
        
        printController.printInfo = printInfo
        printController.printingItem = image
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            printController.present(animated: true, completionHandler: nil)
        }
    }
    
    func openICloud() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeItem)], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource
extension FilesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let filesInSection = files[section]
        if let firstFile = filesInSection.first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let dateString = dateFormatter.string(from: firstFile.date)
            return dateString
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .systemGray
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "FilesCell", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FilesCell")
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .gray
        cell.detailTextLabel?.font = .systemFont(ofSize: 11)
        cell.imageView?.image = UIImage(named: "docum")
        
        //setup Accessory
        let accessoryImage = UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let accessoryImageView = UIImageView(image: accessoryImage)
        cell.accessoryView = accessoryImageView
        
        let file = files[indexPath.section][indexPath.row]
        file.id = Int16(indexPath.row)
        
        cell.textLabel?.text = file.name
        if let fileSize = CoreDataManager.shared.getFileSize(file: file) {
            let formattedSize = ByteCountFormatter.string(fromByteCount: fileSize, countStyle: .file)
            cell.detailTextLabel?.text = "\(file.type) (\(formattedSize))"
        } else {
            cell.detailTextLabel?.text = file.type
        }
        
        return cell
    }
    
}
// MARK: - TableView Delegate
extension FilesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = files[indexPath.section][indexPath.row]
        
        if let imageData = file.data, let image = UIImage(data: imageData) {
            let printInfo = UIPrintInfo(dictionary:nil)
            printInfo.outputType = UIPrintInfo.OutputType.general
            printInfo.jobName = "Printing Image"
            
            let printController = UIPrintInteractionController.shared
            printController.printInfo = printInfo
            printController.printingItem = image
            printController.present(animated: true, completionHandler: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.deleteFile(at: indexPath)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func deleteFile(at indexPath: IndexPath) {
        let file = files[indexPath.section][indexPath.row]
        // Delete from CoreData
        CoreDataManager.shared.deleteFile(with: file.name)
        // Delete from array
        files[indexPath.section].remove(at: indexPath.row)
        // Delete from table
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension FilesController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            // Выбор изображения выполнен
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let imageName = image.description
                // Сохранение изображения в CoreData
                CoreDataManager.shared.createFile(name: imageName, data: imageData, type: "")
                print("Изображение успешно сохранено в CoreData.")
            }
            // Use the captured image for printing
            presentPrintController(with: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension FilesController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Обработка выбранного документа из iCloud
        if let selectedURL = urls.first {
            // Добавьте ваш код для обработки выбранного документа
            let printController = UIPrintInteractionController.shared
            printController.delegate = self
            
            let printInfo = printController.printInfo
            printInfo?.jobName = selectedURL.lastPathComponent
            printController.printInfo = printInfo
            printController.printingItem = selectedURL
            printController.present(animated: true, completionHandler: nil)
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Выбор документа из iCloud отменен")
    }
}
