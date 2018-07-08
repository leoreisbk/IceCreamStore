//
//  IceCreamItem.swift
//  IceCreamStore
//
//  Created by Leonardo Reis on 06/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import Foundation
import Firebase

struct IceCreamItem {
	let ref: DatabaseReference?
	let key: String
	let name: String
	let weight: String?
	let flavor: String
	let color: String
	let temp: String

	init(name: String, flavor: String, color: String, temp: String, weight: String?, key: String = "") {
		self.ref = nil
		self.key = key
		self.name = name
		self.flavor = flavor
		self.weight = weight
		self.temp = temp
		self.color = color
	}

	init?(snapshot: DataSnapshot) {
		guard
			let value = snapshot.value as? [String: AnyObject],
			let name = value["name"] as? String,
			let flavor = value["flavor"] as? String,
			let weight = value["weight"] as? String,
			let temp = value["temp"] as? String,
			let color = value["color"] as? String else {
				return nil
		}
		
		self.ref = snapshot.ref
		self.key = snapshot.key
		self.name = name
		self.flavor = flavor
		self.weight = weight
		self.temp = temp
		self.color = color
	}

	func toAnyObject() -> Any {
		return [
			"name": name,
			"flavor": flavor,
			"weight": weight!,
			"temp": temp,
			"color": color
		]
	}
}
