//
//  TBSelectiveCheckoutViewController.swift
//  SelectiveCheckoutPOC
//
//  Created by Sangat Baral on 21/09/21.
//

import Foundation
import UIKit

class TBCheckoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TBCheckoutInteractorDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    var interactor: TBCheckoutInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Checkout"
        self.prepareEngine()
        self.prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    fileprivate func prepareEngine() {
        TBCheckoutEngine.startBooting(interactor: self.interactor)
    }
    
    deinit {
        print("TBCheckout ViewController De-Allocated")
    }
    
    internal func prepareTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.checkoutButton.layer.cornerRadius = 12
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.7)
        self.tableView.layer.cornerRadius = 12
        self.tableView.allowsMultipleSelection = true
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "TBCheckoutCell", bundle: nil),
                                     forCellReuseIdentifier: "TBCheckoutCell")
        tableView?.register(myCell.nib, forCellReuseIdentifier: myCell.identifier)
        
    }
    
    func didReloadBaseView() {
        self.tableView.reloadData()
    }
    func pushNavigationController(controller: UIViewController) {
        
    }
    @IBAction func checkoutPressed(_ sender: UIButton) {
        let array = interactor?.selectedItems.map({ "\n Product Name: \($0.title) \n Product Code: \($0.productCode) \n USSID: \($0.ussid)\n" }) ?? []
        array.forEach { string in
            print(string)
        }
        tableView.reloadData()
    }
}


extension TBCheckoutViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.interactor?.getRowCount(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.interactor?.prepareTableViewCell(tableView: self.tableView, indexPath: indexPath) ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.prepareDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.interactor?.prepareDidDeSelect(tableView: tableView, indexPath: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
}
