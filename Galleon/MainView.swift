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

class MainView: AbstractNavigationDrawerController<IMainPresenter>,
	IMainView, LogDelegate {
	
	private var progressView: UIActivityIndicatorView!;
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated);
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
	
	override func prepare() {
		super.prepare();
		setLeftViewWidth(width: Screen.width * 0.75, isHidden: true, animated: true); // TODO
	}
	
	func showProgress() {
		progressView?.startAnimating();
	}
	
	func hideProgress() {
		progressView?.stopAnimating();
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
			_ = snackbarController?.animate(snackbar: .hidden, delay: 3);
		}
	}
	
	func prepareView() {
		progressView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge);
		progressView.color = Color.red.base;
		
		view.layout(progressView)
			.center();
	}
	
	func pushViewController(viewController: UIViewController, animated: Bool, asFragment: Bool) {
		if asFragment {
			if let rootController = toolbarController {
				rootController.transition(to: viewController);
			}
		} else {
			if let rootController = navigationController {
				rootController.pushViewController(viewController, animated: animated);
			}
		}
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: MainView.self);
	}
}
