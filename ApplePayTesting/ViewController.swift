//
//  ViewController.swift
//  ApplePayTesting
//
//  Created by Adel Radwan on 06/01/2022.
//

import UIKit
import PassKit

class ViewController: UIViewController {
    
    private lazy var paymentButton: PKPaymentButton = {
        let button = PKPaymentButton()
        button.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.makeApplePayEvent), for: .touchUpInside)
        return button
    }()
    
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.adel.org.sa.ApplePayTesting"
        request.supportedNetworks  = [.mada, .visa, .masterCard]
        request.supportedCountries = ["SA", "UA"]
        request.countryCode = "SA"
        request.currencyCode = "SAR"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "App test", amount: 10.99)]
        return request
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(paymentButton)
        NSLayoutConstraint.activate([
            paymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            paymentButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            paymentButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    //MARK: - Apple pay
    @objc func makeApplePayEvent(){
        guard let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) else { return }
        controller.delegate = self
        present(controller, animated: true, completion: nil)
        
    }
}

//MARK: - PKPaymentAuthorizationViewControllerDelegate
extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
 
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
 
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
 
}

