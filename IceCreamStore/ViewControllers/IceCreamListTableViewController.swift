//
//  IceCreamListTableViewController.swift
//  IceCreamStore
//
//  Created by Leonardo Reis on 06/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

protocol PresenterToViewProtocol: class {
	func showIceCreamList(iceCreamItems: [IceCreamItem])
	func showError();
}

class IceCreamListTableViewController: UIViewController {
	var items: [IceCreamItem] = [] {
		didSet {
			self.tableView.reloadData()
		}
	}
	
	var presenter: ViewToPresenterProtocol?

	@IBOutlet weak var tableView: UITableView!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.presenter?.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Ice Cream Store"
	}
}

 // MARK: UITableView Delegate

extension IceCreamListTableViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IceCreamCell", for: indexPath) as! IceCreamTableViewCell
		let icecreamItem = items[indexPath.row]
		cell.setupCell(icecreamItem)
		return cell
	}
}

 // MARK: Protocols

extension IceCreamListTableViewController: PresenterToViewProtocol {
	func showIceCreamList(iceCreamItems: [IceCreamItem]) {
		self.items = iceCreamItems
	}
	
	func showError() {
		let alert = UIAlertController(title: "Alert", message: "Problem Fetching Ice Creams", preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
