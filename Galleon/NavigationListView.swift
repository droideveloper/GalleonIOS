/*
 * Galleon Copyright (C) 2016 Fatih.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
import UIKit

import Core
import Material

class NavigationListView: AbstractViewController<INavigationListPresenter>,
	INavigationListView, LogDelegate, UITableViewDelegate {
	
	private var progressView: UIActivityIndicatorView!;
	private var listView: UITableView!;
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated);
		presenter?.viewWillAppear(animated);
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		presenter?.viewDidLoad();
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated);
		presenter?.viewWillDisappear(animated);
	}
	
	func prepareView() {
		listView = UITableView();
		listView.separatorStyle = .none;
		
		listView.backgroundView = nil;
		listView.backgroundColor = Color.grey.darken3;
		
		listView.tableFooterView = UIView(frame: .zero);
		
		listView.dataSource = presenter?.adapter();
		listView.delegate = self;
		
		listView.allowsMultipleSelection = false;
		listView.register(NavigationViewHolder.self, forCellReuseIdentifier: NavigationViewHolder.kIdentifier);
		
		view.layout(listView)
			.edges();
		
		progressView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge);
		progressView.tintColor = Color.red.base;
		
		view.layout(progressView)
			.center();
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let view = tableView.cellForRow(at: indexPath);
		view?.setSelected(true, animated: false);
		let entity = presenter?.navigationEntityAt(index: indexPath.row);
		if let navigationEntity = entity {
			presenter?.selectNavigation(entity: navigationEntity);
		}
	}
	
	@objc func hideError() {
		if let snackbar = snackbarController?.snackbar {
			snackbar.layer.removeAllAnimations();
		}
		_ = snackbarController?.animate(snackbar: .hidden);
	}
	
	func notifyDataSourceChanged() {
		listView.reloadData();
	}
	
	func showProgress() {
		progressView.startAnimating();
	}
	
	func hideProgress() {
		progressView.stopAnimating();
	}
	
	func showError(_ error: String, action actionText: String?, completed on: (() -> Void)?) {
		if let snackbar = snackbarController?.snackbar {
			snackbar.text = error;
			if let str = actionText {
				let button = Flat(title: str);
				button.callback = on;
				button.addTarget(self, action: #selector(hideError), for: .touchUpInside);
				snackbar.rightViews = [button];
			}
			_ = snackbarController?.animate(snackbar: .visible);
			_ = snackbarController?.animate(snackbar: .hidden, delay: 3);
		}
	}
	
	func openMenu() {
		if let drawerLayout = navigationDrawerController {
			if !drawerLayout.isLeftViewOpened {
				drawerLayout.openLeftView();
			}
		}
	}
	
	func closeMenu() {
		if let drawerLayout = navigationDrawerController {
			if drawerLayout.isLeftViewOpened {
				drawerLayout.closeLeftView();
			}
		}
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: NavigationListView.self);
	}
}
