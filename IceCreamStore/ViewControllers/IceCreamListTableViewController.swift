//
//  IceCreamListTableViewController.swift
//  IceCreamStore
//
//  Created by Leonardo Reis on 06/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit
import SDStateTableView

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

	@IBOutlet weak var tableView: SDStateTableView!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
//		tableView.setState(.loading(message: "Loading data..."))
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
		switch (tableView as! SDStateTableView).currentState {
		case .dataAvailable:
			tableView.separatorStyle = .singleLine
			return items.count
		default:
			tableView.separatorStyle = .none
			return 0
		}
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
		if self.items.count > 0 {
			tableView.setState(.dataAvailable)
		} else {
			tableView.setState(.withImage(image: "empty_cart",
										  title: "EMPTY STORE",
										  message: "Please create an item in your factory first"))
		}
	}
	
	func showError() {
		tableView.setState(.withImage(image: "server_error",
									  title: "SERVER ERROR",
									  message: "We are notified and working on it, we will be back soon"))
	}
}
