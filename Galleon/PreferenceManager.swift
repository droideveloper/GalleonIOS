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

class PreferenceManager: IPreferenceManager {

	private var settings: [String: Any];

	private let kAutoSync				= "isAutoSync";
	private let kRememberMe			= "isRememberMe";
	private let kSyncDirectory	= "SyncDirectory";
	private let kToolsDirectory = "ToolsDirectory";
	
	private let kUsername				= "Username";
	private let kPassword				= "Password";
	
	private let kToken					= "Token";
	
	var isAutoSync: Bool {
		get {
			if let autoSync = settings[kAutoSync] as? Bool {
				return autoSync;
			}
			return false;
		}
		set {
			settings[kAutoSync] = newValue;
		}
	}
	
	var isRememberMe: Bool {
		get {
			if let rememberMe = settings[kRememberMe] as? Bool {
				return rememberMe;
			}
			return false;
		}
		set {
			settings[kRememberMe] = newValue;
		}
	}
	
	var syncDirectory: String? {
		get {
			if let directory = settings[kSyncDirectory] as? String {
				return directory;
			}
			return nil;
		}
		set {
			settings[kSyncDirectory] = newValue;
		}
	}
	
	var toolsDirectory: String? {
		get {
			if let directory = settings[kToolsDirectory] as? String {
				return directory;
			}
			return nil;
		}
		set {
			settings[kToolsDirectory] = newValue;
		}
	}
	
	var username: String? {
		get {
			if let u = settings[kUsername] as? String {
				return u;
			}
			return nil;
		}
		set {
			settings[kUsername] = newValue;
		}
	}
	
	var password: String? {
		get {
			if let p = settings[kPassword] as? String {
				return p;
			}
			return nil;
		}
		set {
			settings[kPassword] = newValue;
		}
	}
	
	var token: String? {
		get {
			if let t = settings[kToken] as? String {
				return t;
			}
			return nil;
		}
		set {
			settings[kToken] = newValue;
		}
	}
	
	private let keyPreferences: String  = "kPreferences";
	
	init() {
		if let set = UserDefaults.standard.value(forKey: keyPreferences) as? [String: Any] {
			self.settings = set;
			print(set);// TODO Delete this
		} else {
			self.settings = [:];
			loadDefaults();
		}
	}
	
	private func loadDefaults() {
		isAutoSync = false;
		isRememberMe = false;
		
		syncDirectory = nil;
		toolsDirectory = nil;
		
		token = nil;
		username = nil;
		password = nil;
	}
	
	deinit {
		UserDefaults.standard.setValue(settings, forKey: keyPreferences)
	}
}
