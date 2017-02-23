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
 
import Core
import RxSwift

class FindCustomerPresenter: AbstractPresenter<IFindCustomerView>,
	IFindCustomerPresenter, LogDelegate,
	UITextFieldDelegate, UITableViewDelegate {
	
	var dataSource: CustomerAdapter?;
	var endpoint: IEndpoint?;
	var subscription: Disposable?;
	
	func viewDidLoad() {
		view?.prepareView();
	}
	
	func adapter() -> UITableViewDataSource? {
		return dataSource;
	}
	
	func provideTableViewDelegate() -> UITableViewDelegate {
		return self;
	}
	
	func provideTextFieldDelegate() -> UITextFieldDelegate {
		return self;
	}
	
	func searchTextChanged(_ textField: UITextField) {
		let query = textField.text;
		if isQueryValid(query: query) {
			view?.showProgress();
			if let endpoint = endpoint, let query = query {
				if let subscription = subscription {
					subscription.dispose();
				}
				subscription = endpoint.queryCustomers(query: query)
					.delay(0.5, scheduler: MainScheduler.instance)
					.subscribe(onNext: success, onError: error, onCompleted: completed);
			}
		}
	}
	
	@objc func homeUpAction() {
		BusManager.post(event: NavigationStateEvent(isOpen: true));
	}
	
	func success(response: ResponseArray<Customer>) {
		dataSource?.dataSource = nil;
		if let content = response.data {
			dataSource?.dataSource = content;
		}
		view?.notifyDataSourceChanged();
	}
	
	func error(error: Error) {
		log(error: error);
		view?.hideProgress();
	}
	
	func completed() {
		view?.hideProgress();
	}
	
	func viewWillDisappear(_ animated: Bool) {
		if let subscription = subscription {
			subscription.dispose();
		}
	}
	
	@objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder();
		return false;
	}
	
	@objc func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// TODO check dataSet
	}
	
	@objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 64;
	}
	
	func viewWillAppear(_ animated: Bool) {	}
	func didReceiveMemoryWarning() { }
	
	private func isQueryValid(query: String?) -> Bool {
		if let query = query {
			return query.characters.count >= 3;
		}
		return false;
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: FindCustomerPresenter.self);
	}
}

