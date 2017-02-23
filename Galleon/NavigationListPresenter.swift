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
import RxCocoa
import RxSwift

class NavigationListPresenter: AbstractPresenter<INavigationListView>,
	INavigationListPresenter, LogDelegate {
	
	var dataSource: NavigationAdapter?;
	var subscription: Disposable?;
	
	private let disposeBag = DisposeBag();
	
	func viewDidLoad() {
		view?.prepareView();		
		loadIfNecessary();
	}
	
	func adapter() -> UITableViewDataSource? {
		return dataSource;
	}
	
	func selectNavigation(entity: Navigation) {
		view?.closeMenu();
		BusManager.post(event: NavigationEvent(navigation: entity));
	}
	
	func navigationEntityAt(index: Int) -> Navigation? {
		if let dataSet = dataSource?.dataSource {
			return dataSet.get(index: index);
		}
		return nil;
	}
	
	func loadIfNecessary() {
		view?.showProgress();
		//load data
		Observable.just(true)
			.flatMap { _ -> Observable<[Navigation]> in
				var dataSet = [Navigation]();
				dataSet.add(item: Navigation(title: NSLocalizedString("Find Customers", comment: "action name that search for customers."), image: .ic_search));
				dataSet.add(item: Navigation(title: NSLocalizedString("Tools", comment: "action name that manipulate files to convert image to pdf."), image: .ic_folder));
				dataSet.add(item: Navigation(title: NSLocalizedString("Settings", comment: "action name that user preferences hold."), image: .ic_settings));
				return Observable.just(dataSet);
		 }.observeOn(MainScheduler.asyncInstance)
			.subscribeOn(MainScheduler.instance)
			.subscribe(	onNext: success, onError: error, onCompleted: completed)
			.addDisposableTo(disposeBag);
	}
	
	func success(data: [Navigation]?) {
		if let data = data {
			dataSource?.dataSource = data;
			view?.notifyDataSourceChanged();
		}
	}
	
	func error(error: Error) {
		log(error: error);
	}
	
	func completed() {
		view?.hideProgress();
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: NavigationListPresenter.self);
	}
	
	// Lifecycle
	func viewWillDisappear(_ animated: Bool) {
		if let subscription = subscription {
			subscription.dispose();
		}
	}
	
	func viewWillAppear(_ animated: Bool) {
		subscription = BusManager.register(on: { [weak self] (event: NavigationStateEvent) in
			if event.isOpen {
				self?.view?.openMenu();
			} else {
				self?.view?.closeMenu();
			}
		});
	}
	
	func didReceiveMemoryWarning() {}
}

