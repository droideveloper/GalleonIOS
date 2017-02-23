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

import Swinject

class ApplicationComponent: AssemblyType {
	
	func assemble(container: Container) {
		// IPreferenceManager
		container.register(IPreferenceManager.self, factory: { _ in PreferenceManager() })
			.inObjectScope(.container);
		// IEndpoint
		container.register(IEndpoint.self, factory: { _ in Endpoint() })
			.initCompleted({ (resolver: ResolverType, e: IEndpoint) in
				if let endpoint = e as? Endpoint {
					endpoint.preferences = resolver.resolve(IPreferenceManager.self);
				}
			}).inObjectScope(.container);		
	}
	
	func loaded(resolver: ResolverType) { }
}
