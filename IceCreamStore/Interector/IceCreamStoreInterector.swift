//
//  IceCreamStoreInterector.swift
//  IceCreamStore
//
//  Created by Leonardo Reis on 13/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit
import Firebase

protocol PresentorToInterectorProtocol: class {
	var presenter: InterectorToPresenterProtocol? {get set}
	var reference: DatabaseReference {get set}
	func fetchIceCreamItems()
}

class IceCreamStoreInterector: PresentorToInterectorProtocol {
	var reference: DatabaseReference = Database.database().reference(withPath: DataBaseManager.IceCreamDatabasePath)
	var presenter: InterectorToPresenterProtocol?
	
	func fetchIceCreamItems() {
		reference.queryOrdered(byChild: DataBaseManager.IceCreamQueryName).observe(.value, with: { snapshot in
			var newItems: [IceCreamItem] = []
			for child in snapshot.children {
				if let snapshot = child as? DataSnapshot,
					let icecreamItem = IceCreamItem(snapshot: snapshot) {
					newItems.append(icecreamItem)
				}
			}
			self.presenter?.iceCreamItemsFetched(iceCreamItems: newItems)
		})
	}
}
