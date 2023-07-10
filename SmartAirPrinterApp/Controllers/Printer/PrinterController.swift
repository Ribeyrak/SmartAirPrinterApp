//
//  PrinterController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 15.06.2023.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Contacts
import ContactsUI

class PrinterController: BaseController, UIPrintInteractionControllerDelegate {
    private enum Constants {
        static var image1 = "scan"
        static var title1 = "Scaner"
        static var description1 = "Scan any document"
        
        static var image2 = "camera"
        static var title2 = "Take photo"
        static var description2 = "Take a photo and print it"
        
        static var image3 = "icloud"
        static var title3 = "iCloud"
        static var description3 = "Print files from iCloud storage"
        
        static var image4 = "photos"
        static var title4 = "Photos"
        static var description4 = "Print photos from gallery"
        
        static var image5 = "text"
        static var title5 = "Text"
        static var description5 = "Print pasted text from clipdoard"
        
        static var image6 = "web"
        static var title6 = "Web Pages"
        static var description6 = "Print any website in full size"
        
        static var image7 = "contacts"
        static var title7 = "Contacts"
        static var description7 = "Print any contact page"
        
        static var image8 = "email"
        static var title8 = "Email"
        static var description8 = "Print files from any email client"
    }
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createCollectionLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var products: [Products] = []
    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func createCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 3, trailing: 8)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func navBarLeftButtonHandler() {
//        let nextVC = ViewController()
//        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    override func navBarRightButtonHandler() {
        let nextVC = FirstGuideVC()
        navigationController?.pushViewController(nextVC, animated: false)
    }
}

// MARK: - Extension
extension PrinterController {
    override func setupViews() {
        super.setupViews()
        view.addSubview(collectionView)
        collectionView.reloadData()
        collectionView.delegate = self
    }
    
    override func constraintViews() {
        super.constraintViews()
        collectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        title = R.Strings.NavBar.printer
        
        //addNavBarButton(at: .left, image: R.Images.Common.dollarButton)
        addNavBarButton(at: .right, image: R.Images.Common.infoButton)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self,
                                forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        products = [
            Products(image: Constants.image1, title: Constants.title1, descript: Constants.description1),
            Products(image: Constants.image2, title: Constants.title2, descript: Constants.description2),
            Products(image: Constants.image3, title: Constants.title3, descript: Constants.description3),
            Products(image: Constants.image4, title: Constants.title4, descript: Constants.description4),
            Products(image: Constants.image5, title: Constants.title5, descript: Constants.description5),
            Products(image: Constants.image6, title: Constants.title6, descript: Constants.description6),
            Products(image: Constants.image7, title: Constants.title7, descript: Constants.description7),
            Products(image: Constants.image8, title: Constants.title8, descript: Constants.description8)
        ]
        
        let filesController = FilesController()
        filesController.delegate = self
    }
    
    // Scaner Function
    func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        
        if UIImagePickerController.isCameraDeviceAvailable(.rear) {
            imagePicker.cameraDevice = .rear
            imagePicker.cameraCaptureMode = .photo
        }
        
        imagePicker.cameraFlashMode = .auto
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Photos Function
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            printController.present(animated: true, completionHandler: nil)
        }
    }
    
    // iCloud Function
    func openICloud() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeItem)], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    // Text File Function
    func createNewTextFile() {
        let textViewController = TextViewController()
        textViewController.delegate = self
        navigationController?.pushViewController(textViewController, animated: true)
    }
    
    func createTextFile(with text: String) -> URL? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentsDirectory?.appendingPathComponent("PrintText.txt")
        
        do {
            try text.write(to: fileURL!, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Error creating text file: \(error.localizedDescription)")
            return nil
        }
    }
    
    func printTextFile(_ fileURL: URL) {
        let printController = UIPrintInteractionController.shared
        printController.delegate = self

        let printInfo = UIPrintInfo.printInfo()
        printInfo.jobName = "Текстовый файл"
        printController.printInfo = printInfo
        printController.printingItem = fileURL
                
        printController.present(animated: true, completionHandler: nil)
    }
    
    // Contacts Function
    func openContacts() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true, completion: nil)
    }
}

// MARK: - CollectionView DataSource
extension PrinterController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let products = products[indexPath.row]
        cell.setup(with: products)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        
        switch indexPath.row {
        case 0:
            print("0")
            openCamera()
        case 1 :
            print("1")
            openCamera()
        case 2 :
            print("2")
            openICloud()
        case 3 :
            print("3")
            openGallery()
        case 4 :
            print("4")
            createNewTextFile()
        case 5 :
            print("5")
            let webViewController = WebVC()
            navigationController?.pushViewController(webViewController, animated: true)
        case 6 :
            print("6")
            openContacts()
        case 7 :
            print("7")
            let openEmailVC = EmailPrintVC()
            navigationController?.pushViewController(openEmailVC, animated: false)
        default:
            break
        }
    }
}

// MARK: - CollectionView Delegate
extension PrinterController: UICollectionViewDelegate {}

// MARK: - Camera Delegate
extension PrinterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - DocumentPicker Delegate (for iCloud)
extension PrinterController: UIDocumentPickerDelegate {
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

// MARK: - TextViewControllerDelegate
extension PrinterController: TextViewControllerDelegate {
    func didFinishEnteringText(_ text: String) {
        let fileURL = createTextFile(with: text)
        if let url = fileURL {
            printTextFile(url)
        } else {
            print("Ошибка при создании текстового файла.")
        }
    }
}

// MARK: - CNContactPickerDelegate
extension PrinterController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        // Обработка выбранного контакта
        guard let contact = contacts.first else {
            return
        }
        
        let printController = UIPrintInteractionController.shared
        printController.delegate = self
        
        let printInfo = UIPrintInfo.printInfo()
        printInfo.jobName = "Contact"
        printController.printInfo = printInfo
        
        let formatter = CNContactFormatter()
        formatter.style = .fullName
        
        let contactString = formatter.string(from: contact)
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: contactString ?? "")
        printController.printFormatter = printFormatter
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            printController.present(animated: true, completionHandler: nil)
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        // Обработка отмены выбора контакта
    }
}

extension PrinterController: FilesControllerDelegate {
    func didTapOpenICloud() {
        openICloud()
    }
    func didTapOpenGallery() {
        openGallery()
    }
}
