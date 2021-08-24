//
//  TableViewCell.swift
//  ViewingPictures
//
//  Created by Pavel Khlebnikov on 24.08.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    var fotosAuthorLabel: UILabel = {
        return FactoryUI.createLabel()
    }()
    var fotosSizeLabel: UILabel = {
        return FactoryUI.createLabel()
    }()
    var fotosImageView: UIImageView = {
        return FactoryUI.createAvatarImageView()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(fotosImageView)
        fotosImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 130, height: 0, enableInsets: false)
        
        addSubview(fotosAuthorLabel)
        fotosAuthorLabel.anchor(top: topAnchor, left: fotosImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: bounds.size.width, height: 50, enableInsets: false)
        
        addSubview(fotosSizeLabel)
        fotosSizeLabel.anchor(top: fotosAuthorLabel.bottomAnchor, left: fotosImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: bounds.size.width, height: 50, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}
