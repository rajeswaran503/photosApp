//
//  ViewControllerExtension.swift
//  PhotosApp
//
//  Created by Rajeswaran on 15/02/23.
//


import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
}

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Photo App", message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
            self?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToast(message: String){
        let alert = UIAlertController(title: "", message: "\(message)", preferredStyle: .alert)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true, completion: nil)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
