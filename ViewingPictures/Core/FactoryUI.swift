//
//  FactoryUI.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 23.07.2021.
//

import UIKit

final class FactoryUI {
    static func createLabel() -> UILabel {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }
    
    static func createAvatarImageView() -> UIImageView {
        let imgView = UIImageView(image: UIImage(named: "icons8-socrates-100"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.autoresizesSubviews = true
        return imgView
    }
}
