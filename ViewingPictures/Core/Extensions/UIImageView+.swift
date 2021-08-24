//
//  UIImageView+.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 22.07.2021.
//

import UIKit

extension UIImageView {
    //Returns activity indicator view centrally aligned inside the UIImageView
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator,
                                         attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator,
                                         attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
    
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "icons8-socrates-100")
            return
        }
        
        let activityIndicator = self.activityIndicator
        
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        
        DispatchQueue.main.async {
            ImageLoader.getImage(imageURLString) { (image) in
                self.image = image
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
