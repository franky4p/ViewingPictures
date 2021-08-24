//
//  TableViewController.swift
//  ViewingPictures
//
//  Created by Pavel Khlebnikov on 24.08.2021.
//

import UIKit
import Unrealm

class TableViewController: UITableViewController {

    var fotos: Results<Photos>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadFotos()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "fotosCellId")
    }
    
    func loadFotos() {
        fotos = Keeper.loadData(Photos.self)
        token = fotos?.observe{ [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fotos?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fotosCellId", for: indexPath) as! TableViewCell

        // Configure the cell...
        cell.fotosImageView.setCustomImage(fotos?[indexPath.row].source?.small)
        cell.fotosAuthorLabel.text = "\(fotos?[indexPath.row].photographer ?? "")"
        cell.fotosSizeLabel.text = "width:\(fotos?[indexPath.row].width ?? 0) height:\(fotos?[indexPath.row].height ?? 0)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vController = storyboard.instantiateViewController(identifier: "details") as! PhotoViewController
        
        vController.adressImage = fotos?[indexPath.row].source?.original
        vController.dateUpload = fotos?[indexPath.row].dateUpload
        self.navigationController?.pushViewController(vController, animated: true)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (fotos?.count ?? 0) / 2 || indexPath.row == (fotos?.count ?? 0) - 1 {
            Session.shared.updateFromServer()
        }
    }
}
