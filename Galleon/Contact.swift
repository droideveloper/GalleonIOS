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

class Contact: NSObject,
	LogDelegate, Mappable {
	
	private let KEY_CITY_ID				= "CityID";
	private let KEY_COUNTRY_ID		= "CountryID";
	private let KEY_CONTACT_NAME	= "ContactName";
	private let KEY_ADDRESS				= "Address";
	private let KEY_CUSTOMER_ID		= "CustomerID";
	private let KEY_PHONE					= "Phone";
	private let KEY_COUNTRY				= "Country";
	private let KEY_CITY					= "City";
	
	var cityId: Int32?;
	var countryId: Int32?;
	var contactName: String?;
	var address: String?;
	var customerId: Int32?;
	var phone: String?;
	var country: Country?;
	var city: City?;
	
	required init?(map: Map) { }
	
	func mapping(map: Map) {
		cityId <- map[KEY_CITY_ID];
		countryId <- map[KEY_COUNTRY_ID];
		contactName <- map[KEY_CONTACT_NAME];
		address <- map[KEY_ADDRESS];
		customerId <- map[KEY_CUSTOMER_ID];
		phone <- map[KEY_PHONE];
		country <- map[KEY_COUNTRY];
		city <- map[KEY_CITY];
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: Contact.self);
	}
}
