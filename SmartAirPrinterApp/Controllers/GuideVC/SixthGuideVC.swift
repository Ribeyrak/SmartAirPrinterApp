//
//  SixthGuideVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 22.06.2023.
//

import UIKit

class SixthGuideVC: UIViewController {
    
    weak var previousViewController: SeventhGuideVC?
    
    // MARK: - Constants
    private enum Constants {
        static let labelText = "Printer is connected to \n the same Wi-Fi"
        static let logoImage = "printLogoImage"
        static let documentImage = "documentImage"
        static let closeButton = "Close"
        static let backButton = "Back"
        static let infoLabelText = "Is your Printer device connected to the same Wi-Fi as your iPhone or iPad?"
    }
    
    var arrayCells = ["   Reconnect iOS  device to Wi-Fi", "   Restart your iOS ", " Restart your  Printer", "   Check printer’s AirPrint support"]
    var imagesCells = ["wifiOnImage", "phoneImage", "littlePrinterImage", "wifiOffImage"]
    
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
    
    private let nextScreenButton: NextScreenButton = {
        let v = NextScreenButton()
        v.setTitleAndColor(Constants.closeButton, .black)
        return v
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
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
        
        view.addSubview(nextScreenButton)
        nextScreenButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.bottom.equalTo(nextScreenButton.snp.top).offset(-20)
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.isScrollEnabled = false
        
        backButton.addTarget(self, action: #selector(previousVC), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
        nextScreenButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func previousVC() {
        let nextVC = FifthGuideVC()
        nextVC.previousViewController = self
        navigationController?.pushViewController(nextVC, animated: false)
    }
    @objc func mainVC() {
        navigationController?.popToRootViewController(animated: false)
    }
}

extension SixthGuideVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = UIColor(hexString: "#606060")
        cell.detailTextLabel?.font = .systemFont(ofSize: 14)
        
        if indexPath.section == 0 {
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.textLabel?.text = "⚠️ Still can’t connect to the Printer?"
            cell.detailTextLabel?.text = "Your Printer is not connected to the same Wi-Fi as your iPhone or iPad."
            cell.detailTextLabel?.numberOfLines = 0
            //cell.layer.cornerRadius = 10
        } else {
            //cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GuideTableViewCell
            cell.textLabel?.text = arrayCells[indexPath.row]
            cell.imageView?.image = UIImage(named: imagesCells[indexPath.row])
            
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

extension SixthGuideVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "DESCRIPTION"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.textColor = UIColor(hexString: "#606060")
        headerView.textLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 90
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0 // Установите здесь желаемую высоту заголовков секций
    }
}
