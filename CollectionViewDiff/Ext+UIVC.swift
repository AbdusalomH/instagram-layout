//
//  Ext+UIVC.swift
//  CollectionViewDiff
//
//  Created by Mac on 8/29/23.
//

import UIKit

fileprivate var container: UIView!

extension UIViewController {
    
    func showLoading() {
        
        container = UIView(frame: view.bounds)
        
        view.addSubview(container)
        
        container.backgroundColor = .systemBackground
        container.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            container.alpha = 0.8
        }
        
        let activity = UIActivityIndicatorView(style: .medium)
        container.addSubview(activity)
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activity.startAnimating()
    }
    
    
    func stopAnimation() {
        DispatchQueue.main.async {
            container.removeFromSuperview()
            container = nil
        }
    }
}
