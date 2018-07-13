//
//  IceCreamTableViewCell.swift
//  IceCreamFactory
//
//  Created by Leonardo Reis on 07/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

class IceCreamTableViewCell: UITableViewCell {
	var iceCreamItem: IceCreamItem?

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var flavorLabel: UILabel!
	@IBOutlet weak var colorLabel: UILabel!
	@IBOutlet weak var tempLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		if let iceCreamItem =  iceCreamItem {
			setupCell(iceCreamItem)
		}
	}
}

extension IceCreamTableViewCell {
	func setupCell(_ iceCreamItem: IceCreamItem) {
		nameLabel.text = iceCreamItem.name
		flavorLabel.text = iceCreamItem.flavor
		colorLabel.text = iceCreamItem.color
		tempLabel.text = iceCreamItem.temp
	}
}
