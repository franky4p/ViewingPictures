//
//  TableViewCell.swift
//  ViewingPictures
//
//  Created by Pavel Khlebnikov on 24.08.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    var fotosLabel: UILabel = {
        return FactoryUI.createLabel()
    }()
    var fotosImageView: UIImageView = {
        return FactoryUI.createAvatarImageView()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(fotosImageView)
        fotosImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 130, height: 130, enableInsets: false)
        
        addSubview(fotosLabel)
        fotosLabel.anchor(top: topAnchor, left: fotosImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: bounds.size.width, height: 40, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
