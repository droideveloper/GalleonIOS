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

import Foundation

import Core
import Material
import RxSwift

class SignUpPresenter: AbstractPresenter<ISignUpView>,
	ISignUpPresenter, LogDelegate, UITextFieldDelegate {
	
	private let usernameRegex = "^(([^<>()\\[\\]\\.,;:\\s@']+(\\.[^<>()\\[\\]\\.,;:\\s@']+)*)|('.+'))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$";
	private let bag = DisposeBag();
	
	var endpoint: IEndpoint?;
	var preferenceManager: IPreferenceManager?;
	
	func viewDidLoad() {
		view?.prepareView();
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		switch textField.returnKeyType {
			case .next:
				let nextTag = textField.tag + 1;
				if let nextResponder = textField.superview?.viewWithTag(nextTag) {
					nextResponder.becomeFirstResponder();
				}
				break;
			case .done:	textField.resignFirstResponder();	break;
			default: break;
		}
		return false;
	}
	
	@objc func usernameDidChange(_ textField: UITextField) {
		if let usernameText = textField as? ErrorTextField {
			usernameText.isErrorRevealed = !isUsernameValid(textField.text);
		}
	}
	
	@objc func passwordDidChange(_ textField: UITextField) {
		if let passwordText = textField as? ErrorTextField {
			passwordText.isErrorRevealed = !isPasswordValid(textField.text);
		}
	}
	
	func onAction() {
		if let creditential = view?.toCrediential() {
			view?.showProgress();
			log(message: "\(creditential)");
			if let injector = view?.application?.injector {
				
			// TODO its content views injected on other views fucked up
				let viewController = injector.resolve(IMainView.self) as! MainView;
				view?.pushViewController(controller: viewController, animated: true);
			}
			/*
			if let endpoint = self.endpoint {
				endpoint.tryLogin(credential: creditential)
					.delay(2, scheduler: MainScheduler.instance)
					.subscribe(onNext: success, onError: error, onCompleted: completed)
					.addDisposableTo(bag);
			}*/
		}
	}
	
	private func success(response: ResponseObject<Session>) {
		if let prefs = preferenceManager as? PreferenceManager {
			prefs.token = response.data?.token;
			/*
				if let container = view?.application?.container {
				let contentView = container.resolve(IFindCustomerView.self) as! FindCustomerView;
				let navigationView = container.resolve(INavigationListView.self) as! NavigationListView;
				
				let mainViewController = MainView(rootViewController: GalleonToolbarController(rootViewController: contentView),
				                                  leftViewController: navigationView,
				                                  rightViewController: nil);
				mainViewController.presenter = container.resolve(IMainPresenter.self);
				
				view?.pushViewController(controller: mainViewController, animated: true);
			}*/
		}
	}
	
	private func error(error: Error) {
		log(error: error);
	}
	
	private func completed() {
		view?.hideProgress();
	}
	
	func textDelegate() -> UITextFieldDelegate {
		return self;
	}
	
	func isPasswordValid(_ password: String?) -> Bool {
		if let str = password {
			return str.characters.count >= 8;
		}
		return false;
	}
	
	func isUsernameValid(_ username: String?) -> Bool {
		if let str = username {
			return str =~ usernameRegex;
		}
		return false;
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: SignUpPresenter.self);
	}
	
	func viewWillAppear(_ animated: Bool) { }
	func viewWillDisappear(_ animated: Bool) { }
	func didReceiveMemoryWarning() { }
}
