//
//  IceCreamStoreRouter.swift
//  IceCreamStore
//
//  Created by Leonardo Reis on 13/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

protocol PresenterToRouterProtocol: class {
	static func createModule() -> UIViewController
}

class IceCreamStoreRouter: PresenterToRouterProtocol {
	static func createModule() -> UIViewController {
		let navController = mainstoryboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
		if let icecreamTableViewController = navController.childViewControllers.first as? IceCreamListTableViewController {
			let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = IceCreamStorePresenter()
			let interactor: PresentorToInterectorProtocol = IceCreamStoreInterector()
			let router: PresenterToRouterProtocol = IceCreamStoreRouter()

			icecreamTableViewController.presenter = presenter
			presenter.view = icecreamTableViewController
			presenter.router = router
			presenter.interector = interactor
			interactor.presenter = presenter
		}
		return navController
	}
}

extension IceCreamStoreRouter {
	static var mainstoryboard: UIStoryboard {
		return UIStoryboard(name:"Main",bundle: Bundle.main)
	}
}
