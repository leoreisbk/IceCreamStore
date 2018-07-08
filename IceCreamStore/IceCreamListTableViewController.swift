//
//  IceCreamListTableViewController.swift
//  IceCreamStore
//
//  Created by Leonardo Reis on 06/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit
import Firebase

class IceCreamListTableViewController: UIViewController {
	var items: [IceCreamItem] = []
	var ref: DatabaseReference!

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			self.tableView.reloadData()
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		ref = Database.database().reference(withPath: DataBaseManager.IceCreamDatabasePath)
		ref.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
			var newItems: [IceCreamItem] = []
			for child in snapshot.children {
				if let snapshot = child as? DataSnapshot,
					let icecreamItem = IceCreamItem(snapshot: snapshot) {
					newItems.append(icecreamItem)
				}
			}

			self.items = newItems
			self.tableView.reloadData()
		})
	}

	override func viewDidLoad() {
		super.viewDidLoad()
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
