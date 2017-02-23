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

import Swinject

class ViewComponent: AssemblyType {
	
	func assemble(container: Container) {
		// ISignUpView
		container.register(ISignUpView.self, factory: { _ in SignUpView() })
			.initCompleted({ (resolver: ResolverType, v: ISignUpView) in
				if let view = v as? SignUpView {
					view.presenter = resolver.resolve(ISignUpPresenter.self);
				}
			});
		// IMainView
		container.register(IMainView.self, factory: { r in
			
			let viewController = r.resolve(IFindCustomerView.self) as! FindCustomerView;
			let navigationController = r.resolve(INavigationListView.self) as! NavigationListView;
			
			return MainView(rootViewController: GalleonToolbarController(rootViewController: viewController),
			                leftViewController: navigationController,
											rightViewController: nil);
			
		}).initCompleted({ (resolver: ResolverType, v: IMainView) in
			if let view = v as? MainView {
				view.presenter = resolver.resolve(IMainPresenter.self);
			}
		});
		// INavigationListView
		container.register(INavigationListView.self, factory: {_ in NavigationListView() })
			.initCompleted({ (resolver: ResolverType, v: INavigationListView) in
				if let view = v as? NavigationListView {
					view.presenter = resolver.resolve(INavigationListPresenter.self);
				}
			});
		// IFindCustomerView
		container.register(IFindCustomerView.self, factory: { _ in FindCustomerView() })
			.initCompleted({ (resolver: ResolverType, v: IFindCustomerView) in
				if let view = v as? FindCustomerView {
					view.presenter = resolver.resolve(IFindCustomerPresenter.self);
				}
			});
		// ISignUpPresenter
		container.register(ISignUpPresenter.self, factory: { _ in SignUpPresenter() })
			.initCompleted({ (resolver: ResolverType, p: ISignUpPresenter) in
				if let presenter = p as? SignUpPresenter {
					presenter.view = resolver.resolve(ISignUpView.self);
					presenter.endpoint = resolver.resolve(IEndpoint.self);
					presenter.preferenceManager = resolver.resolve(IPreferenceManager.self);
				}
			});
		// IMainPresenter
		container.register(IMainPresenter.self, factory: { _ in MainPresenter() })
			.initCompleted({ (resolver: ResolverType, p: IMainPresenter) in
				if let presenter = p as? MainPresenter {					
					presenter.view = resolver.resolve(IMainView.self);
				}
			});		
		// INavigationListPresenter
		container.register(INavigationListPresenter.self, factory: { _ in NavigationListPresenter() })
			.initCompleted({ (resolver: ResolverType, p: INavigationListPresenter) in
				if let presenter = p as? NavigationListPresenter {
					presenter.view = resolver.resolve(INavigationListView.self);
					presenter.dataSource = resolver.resolve(UITableViewDataSource.self, name: AdapterComponent.kNavigationAdapter) as? NavigationAdapter;
				}
			});
		// IFindCustomerPresenter
		container.register(IFindCustomerPresenter.self, factory: { _ in
			return FindCustomerPresenter();
		}).initCompleted({ (resolver: ResolverType, p: IFindCustomerPresenter) in
			if let presenter = p as? FindCustomerPresenter {
				presenter.view = resolver.resolve(IFindCustomerView.self);
				presenter.endpoint = resolver.resolve(IEndpoint.self);
				presenter.dataSource = resolver.resolve(UITableViewDataSource.self, name: AdapterComponent.kCustomerAdapter) as? CustomerAdapter;
			}
		});
	}
	
	func loaded(resolver: ResolverType) { }
}
