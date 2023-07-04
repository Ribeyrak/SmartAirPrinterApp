//
//  ViewController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 14.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    //MARK: - Constants
    private enum Constants {
        static let labelText = "Unlimited Access \n To All Features"
        static let logoImage = "printLogoImage"
        static let termsOfServiceButtonTitle = "Terms Of Service"
        static let pravicyPolicyButtonTitle = "Privacy policy"
        static let nextScreenButton = "Continue"
        static let restoreButton = "Restore"
        static let firstLabel = "✔️ Print with AirPrint"
        static let secondtLabel = "✔️ Edit photo"
        static let thirdLabel = "✔️ Scan documents"
        static let fourthLabel = "✔️ No ads and no limits"
        static let identifier = "MyCell"
        static let trialLabel = "3 days free"
        static let totalPricePerYear = "then 49,99 USD/year"
        static let totalPricePerMonth = "then 11,99 USD/month"
        static let pricePerYearText = "4,00 USD/month"
        static let pricePerMonthText = "11,99 USD/month"
    }

    var subscriptions: [Subscriptions] = []
    
    //MARK: - UI
    let closeButton: UIButton = {
        let v = UIButton(type: .system)
        v.setImage(UIImage(systemName: "xmark"), for: .normal)
        v.tintColor = .systemGray
        return v
    }()
    
    let restoreButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle(Constants.restoreButton, for: .normal)
        v.tintColor = .systemGray
        return v
    }()
    
    let logoView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        v.layer.cornerRadius = 10
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.5
        v.layer.shadowOffset = CGSize(width: 4, height: 4)
        v.layer.shadowRadius = 4
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
        v.numberOfLines = 2
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        v.font = .systemFont(ofSize: 24, weight: .black)
        return v
    }()
    
    let mainView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return v
    }()
    
    private let stackView: UIStackView = {
        let v = UIStackView()
        v.spacing = 10
        v.axis = .vertical
        v.distribution = .fillEqually
        return v
    }()
    private let firstLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.firstLabel
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return v
    }()
    private let secondLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.secondtLabel
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return v
    }()
    private let thirdLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.thirdLabel
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return v
    }()
    private let fourthLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.fourthLabel
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return v
    }()
    
    private let productTableView = UITableView(frame: .zero, style: .grouped)
    
    private let nextScreenButton: NextScreenButton = {
        let v = NextScreenButton()
        v.setTitleAndColor(Constants.nextScreenButton, .black)
        return v
    }()
    
    private let termsOfServiceButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle(Constants.termsOfServiceButtonTitle, for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 14)
        v.setTitleColor(.systemGray.withAlphaComponent(0.6), for: .normal)
        return v
    }()
    
    private let separatorView: UILabel = {
        let v = UILabel()
        v.text = "|"
        v.textColor = .systemGray.withAlphaComponent(0.6)
        return v
    }()
    
    private let privacyPolicyButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle(Constants.pravicyPolicyButtonTitle, for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 14)
        v.setTitleColor(.systemGray.withAlphaComponent(0.6), for: .normal)
        return v
    }()
    
    //MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        availableSubscriptions()
        createTableView()
        setupUI()
        configureAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Private functions
    private func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(view.frame.height / 1.5)
            $0.bottom.equalToSuperview()
        }
        
        view.addSubview(logoView)
        logoView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(85)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoView.snp.bottom)
            $0.bottom.equalTo(mainView.snp.top)
        }
        
        logoView.addSubview(logo)
        logo.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        mainView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        mainView.addSubview(termsOfServiceButton)
        termsOfServiceButton.snp.makeConstraints {
            $0.trailing.equalTo(separatorView).offset(-15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainView.addSubview(privacyPolicyButton)
        privacyPolicyButton.snp.makeConstraints {
            $0.leading.equalTo(separatorView).offset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainView.addSubview(nextScreenButton)
        nextScreenButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(54)
        }
        
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(thirdLabel)
        stackView.addArrangedSubview(fourthLabel)
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(94)
        }
        
        productTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mainView.addSubview(productTableView)
        productTableView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(40)
            $0.bottom.equalTo(nextScreenButton.snp.top)
            $0.leading.trailing.equalToSuperview().inset(13)
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(28)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(restoreButton)
        restoreButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(28)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        closeButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: restoreButton)
    }
    
    private func availableSubscriptions() {
        subscriptions = [
            Subscriptions(trialLabel: Constants.trialLabel, totalPrice: Constants.totalPricePerMonth, pricePerMonth: Constants.pricePerMonthText),
            Subscriptions(trialLabel: Constants.trialLabel, totalPrice: Constants.totalPricePerYear, pricePerMonth: Constants.pricePerYearText)
        ]
    }
    
    private func createTableView() {
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: Constants.identifier)
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.sectionHeaderHeight = 0
        productTableView.separatorStyle = .none
        productTableView.backgroundColor = .clear
    }
    
    // MARK: - Actions
    @objc func mainVC() {
        let nextVC = TabBarController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
}

//MARK: - TableView DataSoure
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return subscriptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath) as! ProductTableViewCell
        
        let subscription = subscriptions[indexPath.section]
        cell.setupCell(with: subscription)
        cell.confige()
        return cell
    }
}

 //MARK: - TableView Delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = nextScreenButton.frame.height
        return rowHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
