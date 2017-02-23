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
import ObjectMapper

class Directory: NSObject,
	LogDelegate, Mappable {

	private let KEY_DIRECTORY_ID				= "DirectoryID";
	private let KEY_PARENT_DIRECTORY_ID = "ParentDirectoryID";
	private let KEY_CUSTOMER_ID					= "CustomerID";
	private let KEY_DIRECTORY_NAME			= "DirectoryName";
	private let KEY_PARENT							= "Parent";
	private let KEY_DOCUMENTS						= "Documents";
	
	var directoryId: Int32?;
	var parentDirectoryId: Int32?;
	var customerId: Int32?;
	var directoryName: String?;
	var parent: Directory?;
	var documents: [Document]?;
	
	required init?(map: Map) { }
	
	func mapping(map: Map) {
		directoryId <- map[KEY_DIRECTORY_ID];
		parentDirectoryId <- map[KEY_PARENT_DIRECTORY_ID];
		customerId <- map[KEY_CUSTOMER_ID];
		directoryName <- map[KEY_DIRECTORY_NAME];
		parent <- map[KEY_PARENT];
		documents <- map[KEY_DOCUMENTS];
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: Directory.self);
	}
}
