//
//  SettingsController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 15.06.2023.
//
import UIKit
import MessageUI

class SettingsController: BaseController {
    
    var titleSection = "GENERAL"
    var titelGeneralCell = ["How to Connect Printer?", "Customer support", "Share our app", "Privacy Policy", "Terms of Service"]
    var settingsImages = ["howConnect", "customerSupport", "shareApp", "privacyPolicy", "privacyPolicy"]
    
    // MARK: - UI
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
}

// MARK: - Extension
extension SettingsController {
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(15)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        title = R.Strings.NavBar.settings
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 44
        tableView.isScrollEnabled = false
    }
}

// MARK: - UITableViewDataSource
extension SettingsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titelGeneralCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //setup Cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = UIColor(hexString: "#606060")
        cell.detailTextLabel?.font = .systemFont(ofSize: 11)
        
        //setup Accessory
        let accessoryImage = UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let accessoryImageView = UIImageView(image: accessoryImage)
        cell.accessoryView = accessoryImageView
        
        //setup selected Cell color
        let selected = UIView()
        selected.backgroundColor = .gray
        cell.selectedBackgroundView = selected
        
        //setup Section
        cell.textLabel?.text = titelGeneralCell[indexPath.row]
        cell.imageView?.image = UIImage(named: settingsImages[indexPath.row])
        
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
        
        if indexPath.section == 1 && indexPath.row == 2 {
            cell.textLabel?.textColor = .systemGray.withAlphaComponent(0.5)
            cell.selectionStyle = .none
            let switchControl = UISwitch()
            switchControl.isEnabled = false
            cell.accessoryView = switchControl
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SettingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleSection
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.textColor = UIColor(hexString: "#606060")
        headerView.textLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 && indexPath.row == 2 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = FirstGuideVC()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            if MFMailComposeViewController.canSendMail() {
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                mailComposer.setToRecipients(["support@example.com"])
                mailComposer.setSubject("Need Support")
                present(mailComposer, animated: true, completion: nil)
            }
        case 2:
            let shareAppActivityViewController = UIActivityViewController(activityItems: ["Check out this app!"], applicationActivities: nil)
            present(shareAppActivityViewController, animated: true, completion: nil)
        case 3:
            let vc = WebViewController(urlString: "https://www.google.com/")
            navigationController?.present(vc, animated: true)
        case 4:
            let vc = WebViewController(urlString: "https://www.youtube.com/")
            navigationController?.present(vc, animated: true)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
