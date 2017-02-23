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

class FindCustomerView: AbstractViewController<IFindCustomerPresenter>,
	IFindCustomerView, LogDelegate {
	
	private var progressView: UIActivityIndicatorView!;
	private var listView: UITableView!;
	
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
		listView.register(CustomerViewHolder.self, forCellReuseIdentifier: CustomerViewHolder.kIdentifier);
		
		listView.separatorStyle = .singleLine;
		listView.separatorColor = Color.grey.lighten2;
		
		listView.backgroundView = nil;
		listView.backgroundColor = Color.grey.base;
		
		listView.tableFooterView = UIView(frame: .zero);
		listView.dataSource = presenter?.adapter();
		listView.delegate = presenter?.provideTableViewDelegate();
		
		view.layout(listView)
			.edges();
		
		progressView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge);
		progressView.color = Color.red.base;
		
		view.layout(progressView)
			.center();
		
		setupToolbar();
	}
	
	func notifyDataSourceChanged() {
		listView.reloadData();
	}
	
	func showProgress() {
		progressView?.startAnimating();
		
		listView.isHidden = true;
	}
	
	func hideProgress() {
		progressView?.stopAnimating();
		
		listView.isHidden = false;
	}
	
	@objc func hideError() {
		if let snackbar = snackbarController?.snackbar {
			snackbar.layer.removeAllAnimations();
		}
		_ = snackbarController?.animate(snackbar: .hidden);
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
			_ = snackbarController?.animate(snackbar: .hidden, delay: 5);
		}
	}
	
	private func setupToolbar() {
		if let toolbar = toolbarController?.toolbar {
			
			let homeUp = IconButton(image: Material.icon(.ic_menu), tintColor: .white);
			homeUp.addTarget(presenter, action: #selector(presenter?.homeUpAction), for: .touchUpInside);
			toolbar.leftViews = [homeUp];
			
			
			let searchBar = SearchBar();
			searchBar.backgroundColor = .clear;
			
			searchBar.textField.clearButtonMode = .always;
			searchBar.textField.placeholder = NSLocalizedString("Search", comment: "Search action that is done by user");
			
			searchBar.textField.font = RobotoFont.light(with: 12);
			searchBar.textColor = .white;
			searchBar.placeholderColor = .white;
			
			searchBar.textField.returnKeyType = .search;
			searchBar.textField.delegate = presenter?.provideTextFieldDelegate();
			searchBar.textField.addTarget(presenter, action: #selector(presenter?.searchTextChanged(_:)), for: .editingChanged);
			
			toolbar.centerViews = [searchBar];
		}
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: FindCustomerView.self);
	}
}
