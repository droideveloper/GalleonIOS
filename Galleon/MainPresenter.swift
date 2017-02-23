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
import RxSwift

class MainPresenter: AbstractPresenter<IMainView>,
	IMainPresenter, LogDelegate {
	
	var subscription: Disposable?;
	var selectedNavigation: Navigation? {
		didSet {
			if let navigation = selectedNavigation {
				log(message: "\(navigation.title) - \(navigation.image)");
				if let delegate = navigation.image {
					switch delegate {
					case .ic_search:
						break;
					case .ic_settings:
						break;
					case .ic_folder:
						break;
					default:
						break;
					}
				}
			}
		}
	}
	
	func viewDidLoad() {
		view?.prepareView();
	}
	
	// Lifecycle
	func viewWillAppear(_ animated: Bool) {
		subscription = BusManager.register(on: { [weak self] (event: NavigationEvent) in
			if self?.selectedNavigation != event.navigation {
				self?.selectedNavigation = event.navigation;
			}
		});
	}
	
	func viewWillDisappear(_ animated: Bool) {
		if let subscription = subscription {
			subscription.dispose();
		}
	}
	
	func didReceiveMemoryWarning() { }
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: MainPresenter.self);
	}
}
