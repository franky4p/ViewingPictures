//
//  PhotoViewController.swift
//  ViewingPictures
//
//  Created by Pavel Khlebnikov on 24.08.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var adressImage: String?
    var dateUpload: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        photo.setCustomImage(adressImage)
        dateLabel.text = "Upload: \(dateUpload ?? Date())"
    }
}
