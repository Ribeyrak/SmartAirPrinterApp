//
//  SeventhGuideVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 23.06.2023.
//

import UIKit
import WebKit

class SeventhGuideVC: UIViewController, WKNavigationDelegate {
    // MARK: - Constants
    private enum Constants {
        static let labelText = "Printer is not connected \n to the same Wi-Fi"
        static let logoImage = "printLogoImage"
        static let documentImage = "documentImage"
        static let closeButton = "Close"
        static let backButton = "Back"
        static let infoLabelText = "Is your Printer device connected to the same Wi-Fi as your iPhone or iPad?"
    }
    
    var titleSection = ["DESCRIPTION", "SOLVING OPTIONS", "SOLVING OPTIONS"]
    var titleCell = ["HP", "Canon", "Epson", "Brother", "Samsung", "Xerox", "Other"]
    var printersImages = ["hp","canon","epson","brother","samsung","xerox","other"]
    
    // MARK: - UI
    let progressBar: UIProgressView = {
        let v = UIProgressView()
        v.layer.masksToBounds = true
        v.progressViewStyle = .default
        v.setProgress(0.8, animated: false)
        v.trackTintColor = .gray
        v.layer.cornerRadius = 6
        v.progressTintColor = .black
        return v
    }()
    
    let closeButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle(Constants.closeButton, for: .normal)
        v.tintColor = R.Colors.active
        return v
    }()
    
    let backButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle(Constants.backButton, for: .normal)
        v.tintColor = R.Colors.active
        v.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        return v
    }()
    
    let logo: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.logoImage)
        return v
    }()
    
    let label: UILabel = {
        let v = UILabel()
        v.text = Constants.labelText
        v.numberOfLines = 0
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        v.font = .systemFont(ofSize: 24, weight: .black)
        return v
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Private functions
    private func setupUI() {
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(5)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(29)
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
        }
        
        view.addSubview(logo)
        logo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(39)
            $0.height.width.equalTo(60)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logo.snp.bottom).offset(16)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
    }
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        
        backButton.addTarget(self, action: #selector(previousVC), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 140
        
    }
    
    // MARK: - Actions
    @objc func previousVC() {
        let nextVC = SixthGuideVC()
        nextVC.previousViewController = self
        navigationController?.pushViewController(nextVC, animated: false)
    }
    @objc func mainVC() {
        navigationController?.popToRootViewController(animated: false)
    }
}

// MARK: - TableView DataSource
extension SeventhGuideVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return 7
        default:
            break
        }
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = UIColor(hexString: "#606060")
        cell.detailTextLabel?.font = .systemFont(ofSize: 14)
        cell.detailTextLabel?.numberOfLines = 0

        
        let selected = UIView()
        selected.backgroundColor = .gray
        cell.selectedBackgroundView = selected
        
        if indexPath.section == 0 {
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.textLabel?.text = "⚠️ Still can’t connect to the Printer?"
            cell.detailTextLabel?.text = "Your Printer is not connected to the same Wi-Fi as your iPhone or iPad."
            cell.detailTextLabel?.numberOfLines = 0
            cell.isUserInteractionEnabled = false
        } else if indexPath.section == 1 {
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.textLabel?.text = "Install your printer app"
            cell.detailTextLabel?.text = "Your Printer is not connected to the same Wi-Fi as your iPhone or iPad. Your Printer is not connected to the same Wi-Fias your iPhone or iPad."
            cell.detailTextLabel?.numberOfLines = 0
            cell.isUserInteractionEnabled = false

        } else {
            cell.textLabel?.text = titleCell[indexPath.row]
            cell.imageView?.image = UIImage(named: printersImages[indexPath.row])
            if indexPath.row != tableView.numberOfRows(inSection: indexPath.section) - 1 {
                let separatorView = UIView()
                separatorView.backgroundColor = tableView.separatorColor
                cell.contentView.addSubview(separatorView)
                separatorView.snp.makeConstraints {
                    $0.leading.trailing.equalToSuperview().inset(10)
                    $0.bottom.equalToSuperview()
                    $0.height.equalTo(1)
                }
            }
        }
        return cell
    }
}

// MARK: - TableView Delegate
extension SeventhGuideVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleSection[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.textColor = UIColor(hexString: "#606060")
        headerView.textLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 2 else {
            return
        }
        
        let urlString = "https://www.google.com/"
        let webViewController = WebViewController(urlString: urlString)
        navigationController?.present(webViewController, animated: true)
    }
}
