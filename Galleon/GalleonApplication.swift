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
import Swinject
 
@UIApplicationMain
class GalleonApplication: UIResponder, UIApplicationDelegate {
 	
 	var window: UIWindow?;
	
	var accentColor: UIColor?				= Color.red.base;
	var primaryDarkColor: UIColor?	= Color.red.darken2;
	
	let assembly: Assembler = {
		return try! Assembler(assemblies: [ApplicationComponent(),
		                                   AdapterComponent(),
		                                   ViewComponent()]);
	}()
	
 	
 	func applicationDidFinishLaunching(_ application: UIApplication) {
		window = UIWindow(frame: Screen.bounds);
		
		let viewStart = injector.resolve(ISignUpView.self) as! SignUpView;
		let viewSnack = GalleonSnackbarController(rootViewController: viewStart);
		
		window!.rootViewController = GalleonNavigationController(rootViewController: viewSnack);
		window!.makeKeyAndVisible();
		
	}
}

//LogDelegate
extension GalleonApplication: LogDelegate {
	public func isLogEnabled() -> Bool {
		return true;
	}
	
	public func getClassTag() -> String {
		return String(describing: GalleonApplication.self);
	}
}
//Injector
extension GalleonApplication {
	var injector: ResolverType {
		return assembly.resolver;
	}
}

//Application Shared
extension UIViewController {
	var application: GalleonApplication? {
		return UIApplication.shared.delegate as? GalleonApplication;
	}
}
