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

class SignUpView: AbstractViewController<ISignUpPresenter>, ISignUpView, LogDelegate {
	
	private let startY: CGFloat = 100;
	private let constant: CGFloat = 48;
	private let viewHeight: CGFloat = 32;
	
	private var logoView: UIImageView!;
	private var usernameText: ErrorTextField!;
	private var passwordText: ErrorTextField!;
	private var signUpButton: FlatButton!;
	private var progressView: UIActivityIndicatorView!;
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = .white;
		setNavigationBarState(isHidden: true);
		presenter?.viewDidLoad();
	}
	
	func prepareView() {
		logoView = UIImageView();
		logoView.image = Material.icon(.ic_cloud_upload)?
			.tint(with: Color.grey.darken3);
		
		logoView.contentMode = .scaleAspectFit;
		logoView.contentScaleFactor = Screen.scale;
		
		view.layout(logoView)
			.size(CGSize(width: constant, height: constant))
			.centerHorizontally()
			.top(startY - viewHeight)
		
		prepareUsernameText();
		preparePasswordText();
		
		signUpButton = FlatButton(title: NSLocalizedString("SIGN UP", comment: "Sign up text with uppercase for each locale."));
		signUpButton.titleColor = .white;
		signUpButton.backgroundColor = Color.red.base;
		signUpButton.depthPreset = .depth3;
		
		signUpButton.addTarget(presenter, action: #selector(presenter?.onAction), for: .touchUpInside);
		
		view.layout(signUpButton)
			.horizontally(left: 8, right: 8)
			.top(constant * 4 + viewHeight + startY);
		
		progressView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge);
		progressView.color = Color.red.base;
		
		view.layout(progressView)
			.center();
	}
	
	func showProgress() {
		progressView?.startAnimating();
		
		logoView.isHidden = true;
		usernameText.isHidden = true;
		passwordText.isHidden = true;
		signUpButton.isHidden = true;
	}
	
	func hideProgress() {
		progressView?.stopAnimating();
		
		logoView.isHidden = false;
		usernameText.isHidden = false;
		passwordText.isHidden = false;
		signUpButton.isHidden = false;
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
	
	func toCrediential() -> Credential? {
		let validated = (presenter?.isUsernameValid(usernameText.text))! && (presenter?.isPasswordValid(passwordText.text))!;
		if validated {
			let password = passwordText.text?.md5()?.toHexString(cased: true);
			return Credential(username: usernameText.text, password: password);
		}
		return nil;
	}
	
	private func prepareUsernameText() {
		usernameText = ErrorTextField();
		
		usernameText.detail = NSLocalizedString("Username is not valid, should be e-mail format", comment: "If username is not email format we show this error.");
		usernameText.detailLabel.font = RobotoFont.light(with: 11);
		usernameText.placeholder = NSLocalizedString("Username", comment: "Username place holder for e-mail formated label");
		
		usernameText.tag = 0; // tab index of view when using returnKey
		usernameText.returnKeyType = .next;
		usernameText.keyboardType = .emailAddress;
		
		let icon = UIImageView();
		icon.image = Material.icon(.ic_mail)?
			.tint(with: Color.grey.darken3);
		
		usernameText.leftView = icon;
		usernameText.leftViewMode = .always;
		usernameText.leftView?.contentMode = .center;
		
		view.layout(usernameText)
			.horizontally(left: 8, right: 8)
			.top(constant + startY);
		
		usernameText.delegate = presenter?.textDelegate();
		usernameText.addTarget(presenter, action: #selector(presenter?.usernameDidChange(_:)), for: .editingChanged);
	}
	
	private func preparePasswordText() {
		passwordText = ErrorTextField();

		passwordText.detail = NSLocalizedString("Password is not valid, should be at least 8 characters", comment: "If password is not at least 8 chararcters format we show this error.");
		passwordText.detailLabel.font = RobotoFont.light(with: 11);
		passwordText.placeholder = NSLocalizedString("Password", comment: "Password place holder for text formated label");
		
		passwordText.tag = 1; // tab index of view when using returnKey
		passwordText.returnKeyType = .done;
		
		let icon = UIImageView();
		icon.image = Material.icon(.ic_settings)?
			.tint(with: Color.grey.darken3);
		
		passwordText.leftView = icon;
		passwordText.leftView?.contentMode = .center;
		passwordText.leftViewMode = .always;
		passwordText.isVisibilityIconButtonEnabled = true;
		
		view.layout(passwordText)
			.horizontally(left: 8, right: 8)
			.top(constant * 2 + viewHeight + startY);
		
		passwordText.delegate = presenter?.textDelegate();
		passwordText.addTarget(presenter, action: #selector(presenter?.passwordDidChange(_:)), for: .editingChanged);
	}
	
	private func setNavigationBarState(isHidden: Bool = false) {
		if let rootController = navigationController {
			rootController.isNavigationBarHidden = isHidden;
		}
	}
	
	func pushViewController(controller: UIViewController, animated: Bool) {
		if let rootController = navigationController {
			rootController.pushViewController(controller, animated: animated);
		}
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: SignUpView.self);
	}
}
