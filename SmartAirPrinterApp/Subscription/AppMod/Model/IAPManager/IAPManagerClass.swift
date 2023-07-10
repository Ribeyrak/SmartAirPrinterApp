//
//  IAPManagerClass.swift
//  ModsApp
//
//  Created by David on 17.04.2023.
//

import Foundation
import SwiftyStoreKit
import StoreKit

protocol IAPManagerClassProtocol: AnyObject {
    func infoAlert(title: String, message: String)
    func goToTheApp()
    func failed()
}

class IAPManagerClass: NSObject  {
    
    static let shared = IAPManagerClass()
    weak var transactionsDelegate: IAPManagerClassProtocol?
    
    public var appProduct = SKProduct()
    private var productID = SubscriptionKey.subscriptionBundleIdentifier
    private var secretKey = SubscriptionKey.subscriptionSharedSecret
    
    private var isRestoreTransaction = true
    
    private let iapError = NSLocalizedString("error_iap", comment: "")
    private let prodIDError = NSLocalizedString("inval_prod_id", comment: "")
    private let restoreError = NSLocalizedString("faledRestore", comment: "")
    private let purchaseError = NSLocalizedString("notPurchases", comment: "")
    
        
    public func loadProductsddddd() {
        SKPaymentQueue.default().add(self)
        let productIdentifiers = Pr0ductID.allCases.compactMap({$0.rawValue})
        let request = SKProductsRequest(productIdentifiers: Set(productIdentifiers))
        request.delegate = self
        request.start()
    }
    
    public func makePurchaseddds() {
        if appProduct.productIdentifier == "" {
            self.transactionsDelegate?.infoAlert(title: iapError, message: prodIDError)
        } else {
            if appProduct.productIdentifier == SubscriptionKey.subscriptionBundleIdentifier {
                let payment = SKPayment(product: appProduct)
                SKPaymentQueue.default().add(payment)
            }
        }
    }
    
    public func makeRestoressss() {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                print("Failed \(results.restoreFailedPurchases)")
            } else if results.restoredPurchases.count > 0 {
                print("\(results.restoredPurchases)")
            } else {
                self.transactionsDelegate?.infoAlert(title: self.restoreError, message: self.purchaseError)
                print("no purchases")
            }
        }
    }
    
    private func completeRestoredStatuseddc() {
        if isRestoreTransaction {
            isRestoreTransaction = false
            validatePurchase { [self] result in
                if result {
                    self.transactionsDelegate?.goToTheApp()
                } else {
                    self.transactionsDelegate?.infoAlert(title: restoreError, message: self.purchaseError)
                }
            }
        }
    }
    
    public func completeAllTransactionssssss() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                if purchase.transaction.transactionState == .purchased || purchase.transaction.transactionState == .restored {
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    print("purchase for prodID:", purchase.productId)
                }
            }
        }
    }
    
    public func validatePurchase(_ resultExamination: @escaping (Bool) -> Void) {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: secretKey)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                print("success \(#function)")
                let productId = self.productID
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    ofType: .autoRenewable,
                    productId: productId,
                    inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let expiryDate, _):
                    print("\(SubscriptionKey.subscriptionBundleIdentifier) is valid until \(expiryDate)")
                    SKProductStorePromotionController.default().update(storePromotionOrder:[self.appProduct], completionHandler: nil)
                    resultExamination(expiryDate > Date())
                case .expired(let expiryDate, _):
                    resultExamination(false)
                    print("\(SubscriptionKey.subscriptionBundleIdentifier) is expired since \(expiryDate)")
                case .notPurchased:
                    resultExamination(false)
                    print("The user has never purchased \(SubscriptionKey.subscriptionBundleIdentifier)")
                }
            case .error(let error):
                resultExamination(false)
                print("Receipt verification failed: \(error)")
            }
        }
    }
}

extension IAPManagerClass: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if let error = transaction.error as? NSError {
                if error.domain == SKErrorDomain {
                    switch (error.code) {
                    case SKError.paymentCancelled.rawValue:
                        print("user cancelled the request")
                    case SKError.paymentNotAllowed.rawValue,SKError.paymentInvalid.rawValue,SKError.clientInvalid.rawValue,SKError.unknown.rawValue:
                        print("this device is not allowed to make the payment")
                    default:
                        break;
                    }
                }
            }
            
            switch transaction.transactionState {
            case .purchased:
                if transaction.payment.productIdentifier == appProduct.productIdentifier {
                    SKPaymentQueue.default().finishTransaction(transaction)
                    SKProductStorePromotionController.default().update(storePromotionOrder: [self.appProduct], completionHandler: nil)
                }
                transactionsDelegate?.goToTheApp()
                print("purchased")
                
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                self.transactionsDelegate?.failed()
                print("failed")
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                completeRestoredStatuseddc()
                print("restores")
            case .purchasing, .deferred:
                print("purchasing")
                break
            default:
                print("default")
                break
            }
        }
    }
}

extension IAPManagerClass: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("requesting to product")
        if let invid = response.invalidProductIdentifiers.first {
            print("invalidProductIdentifiers", invid)
        }
        guard response.products.count != 0 else {
            print("no product")
            return
        }
        let requestProducts = response.products
        if let prod = requestProducts.first {
            appProduct = prod
            print("Founded product: \(appProduct.productIdentifier)")
        }
    }
}


