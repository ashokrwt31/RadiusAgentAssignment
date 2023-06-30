//
//  UIViewController.swift
//  RadiusAssignment
//
//  Created by Ashok Rawat on 29/06/23.
//

import UIKit

extension UIViewController {
    func showToast(message: String, font: UIFont = UIFont.systemFont(ofSize: 18, weight: .medium)) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width / 2 - 150, y: view.frame.size.height - 100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.systemPink.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}
