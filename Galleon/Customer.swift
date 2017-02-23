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

class Customer: NSObject,
	LogDelegate, Mappable {
	
	private let KEY_CUSTOMER_ID	= "CustomerID";
	private let KEY_FIRST_NAME	= "FirstName";
	private let KEY_MIDDLE_NAME	= "MiddleName";
	private let KEY_LAST_NAME		= "LastName";
	private let KEY_IDENTITY_NO	= "Identity";
	private let KEY_CATEGORY_ID	= "CategoryID";
	private let KEY_CATEGORY		= "Category";
	private let KEY_CONTACTS		= "Contacts";

	var customerId: Int32?;
	var firstName: String?;
	var middleName: String?;
	var lastName: String?;
	var identity: String?;
	var categoryId: Int32?;
	var category: Category?;
	var contacts: [Contact]?;
	
	required init?(map: Map) { }
	
	func mapping(map: Map) {
		customerId <- map[KEY_CUSTOMER_ID];
		firstName <- map[KEY_FIRST_NAME];
		middleName <- map[KEY_MIDDLE_NAME];
		lastName <- map[KEY_LAST_NAME];
		identity <- map[KEY_IDENTITY_NO];
		categoryId <- map[KEY_CATEGORY_ID];
		category <- map[KEY_CATEGORY];
		contacts <- map[KEY_CONTACTS];
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: Customer.self);
	}
}
