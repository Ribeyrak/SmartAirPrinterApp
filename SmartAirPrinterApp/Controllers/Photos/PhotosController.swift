//
//  PhotosController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 15.06.2023.
//

import UIKit
import MobileCoreServices

class PhotosController: BaseController {
    
    var imageCounter = 1
    
    // MARK: - UI
    let image: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "photosImageIcon")
        return v
    }()
    
    let mainLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 24, weight: .bold)
        v.textColor = .black
        v.text = "Photo Editor"
        v.textAlignment = .center
        return v
    }()
    
    let discriptionLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 14)
        v.textColor = .gray
        v.text = "Edit your photos and then print \n directly via AirPrint"
        v.numberOfLines = 0
        v.textAlignment = .center
        return v
    }()
    
    let openGalleryButton: NextScreenButton = {
        let v = NextScreenButton()
        v.setTitleAndColor("Open gallery", UIColor(hexString: "#3447F6"))
        v.titleLabel?.textColor = .black
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [image, mainLabel, discriptionLabel, openGalleryButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Functions
    override func navBarLeftButtonHandler() {
//        let nextVC = ViewController()
//        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    override func navBarRightButtonHandler() {
        openGallery()
    }
}

extension PhotosController {
    override func setupViews() {
        super.setupViews()
        
        openGalleryButton.snp.makeConstraints {
            $0.width.equalTo(200)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        title = R.Strings.NavBar.photos
        //addNavBarButton(at: .left, image: R.Images.Common.dollarButton)
        addNavBarButton(at: .right, image: R.Images.Common.plusButton)
        
        openGalleryButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
    }
    
    @objc func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func moveToFiles() {
        guard let tabBarController = self.tabBarController else {
            return
        }
        tabBarController.selectedIndex = Tabs.files.rawValue
    }
}

extension PhotosController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            
            // Выбор изображения выполнен
            if let imageData = selectedImage.jpegData(compressionQuality: 1.0) {
                let imageName = "Photo \(UUID().uuidString)"
                // Сохранение изображения в CoreData
                CoreDataManager.shared.createFile(name: imageName, data: imageData, type: "")
                print("Изображение успешно сохранено в CoreData.")
                imageCounter += 1
                
                // Печать изображения
                if UIPrintInteractionController.isPrintingAvailable {
                    let printInfo = UIPrintInfo(dictionary: nil)
                    printInfo.outputType = .photo
                    printInfo.jobName = imageName
                    
                    let printController = UIPrintInteractionController.shared
                    printController.printInfo = printInfo
                    printController.printingItem = UIImage(data: imageData)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        printController.present(animated: true, completionHandler: nil)
                    }
                } else {
                    moveToFiles()
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
