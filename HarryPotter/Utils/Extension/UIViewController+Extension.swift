//
//  UIViewController+Extension.swift
//  HarryPotter
//
//  Created by Elif Parlak on 29.12.2024.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    //MARK: Reuse Identifiers
    static var identifier: String {
          return String(describing: self)
      }
    
    //MARK: Present Alert
    func presentAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: buttonTitle, style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
    
    //MARK: Show Loading View
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    //MARK: Dismiss Loading View
    func dismissLoadingView() {
        func dismissLoadingView() {
            DispatchQueue.main.async {
                containerView.removeFromSuperview()
                containerView = nil
            }
        }
    }
}
