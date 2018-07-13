//
//  IceCreamStorePresenter.swift
//  IceCreamStore
//
//  Created by Leonardo Reis on 13/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

protocol ViewToPresenterProtocol: class {
	var view: PresenterToViewProtocol? {get set}
	var interector: PresentorToInterectorProtocol? {get set}
	var router: PresenterToRouterProtocol? {get set}
	func reloadData()
}

protocol InterectorToPresenterProtocol: class {
	func iceCreamItemsFetched(iceCreamItems: [IceCreamItem]);
	func iceCreamItemsFetchedFailed();
}

class IceCreamStorePresenter: ViewToPresenterProtocol {
	var view: PresenterToViewProtocol?
	
	var interector: PresentorToInterectorProtocol?
	var router: PresenterToRouterProtocol?
	
	func reloadData() {
		interector?.fetchIceCreamItems()
	}
}


extension IceCreamStorePresenter: InterectorToPresenterProtocol {
	func iceCreamItemsFetched(iceCreamItems: [IceCreamItem]) {
		view?.showIceCreamList(iceCreamItems: iceCreamItems)
	}
	
	func iceCreamItemsFetchedFailed() {
		view?.showError()
	}
}
