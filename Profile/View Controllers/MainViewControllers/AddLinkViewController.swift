//
//  AddLinkViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 12.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class AddLinkViewController: UIViewController, AddLinkViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var basicURLLabel: UILabel!
    
    let cellID = "TypeLinkCell"
    var viewModel : AddLinkViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
    }
        func hideKeyboard() {
            self.view.endEditing(true)
    }

    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        guard sender.text != nil else { return }
        viewModel.linkDidChange(sender.text!)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        viewModel.saveLinkToProfile()
    }
    
    

}

extension AddLinkViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LinkTypeTableCell
        cell.titleLabel.text = viewModel.typesLink[indexPath.item].name
        cell.logoImageView.image = UIImage(named: viewModel.typesLink[indexPath.item].imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        basicURLLabel.text = viewModel.typesLink[indexPath.item].basicURL
        viewModel.typeLinkDidChange(viewModel.typesLink[indexPath.item])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.typesLink.count
    }

}
