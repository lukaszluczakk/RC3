//
//  UIViewController.swift
//  RC3
//
//  Created by Łukasz Łuczak on 07/11/2021.
//

import UIKit
import Combine

extension UIViewController {
    func handleCompletion<T: Error>(_ completion: Subscribers.Completion<T>, handler: (T) -> Void) -> Void {
        switch completion {
        case .failure(let err):
            handler(err)
        case .finished:
            print("Finished successfully!")
        }
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
