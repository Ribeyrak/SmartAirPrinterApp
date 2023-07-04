//
//  FilesController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 15.06.2023.
//

import UIKit

class FilesController: BaseController {
    private var files: [Files] = []
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
        files = CoreDataManager.shared.fetchFiles()
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
        let dollarButton = UIBarButtonItem(image: R.Images.Common.dollarButton,  style: .plain, target: self, action: #selector(didTapDollarButton))
        let squadeButton = UIBarButtonItem(image: R.Images.Common.squadeButton,  style: .plain, target: self, action: #selector(didTapSquadeButton))
        navigationItem.leftBarButtonItems = [dollarButton, squadeButton]
        
        let listButton = UIBarButtonItem(image: R.Images.Common.listButton,  style: .plain, target: self, action: #selector(didTapListButton))
        let plusButton = UIBarButtonItem(image: R.Images.Common.plusButton,  style: .plain, target: self, action: #selector(didTapPlusButton))
        navigationItem.rightBarButtonItems = [plusButton, listButton]
        
        // setup table
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilesCell")
    }
    
    // MARK: - Actions
    @objc func didTapDollarButton(sender: AnyObject) {
        let nextVC = ViewController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func didTapSquadeButton(sender: AnyObject) {
        print("2")
    }
    
    @objc func didTapListButton(sender: AnyObject) {
        print("3")
    }
    
    @objc func didTapPlusButton(sender: AnyObject) {
        print("4")
    }
}

// MARK: - TableView DataSource
extension FilesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Files"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilesCell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .gray
        
        //setup Accessory
        let accessoryImage = UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let accessoryImageView = UIImageView(image: accessoryImage)
        cell.accessoryView = accessoryImageView
        
        let file = files.reversed()[indexPath.row]
        
        cell.textLabel?.text = file.name
        cell.detailTextLabel?.text = file.type
        
        return cell
    }
    
}
// MARK: - TableView Delegate
extension FilesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = files.reversed()[indexPath.row]
        
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
}

extension FilesController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
