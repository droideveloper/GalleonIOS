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

class City: NSObject,
	LogDelegate, Mappable {
	
	private let KEY_CITY_ID			= "CityID";
	private let KEY_COUNTRY_ID	= "CountryID";
	private let KEY_CITY_NAME		= "CityName";
	
	var cityId: Int32?;
	var countryId: Int32?;
	var cityName: String?
	
	required init?(map: Map) { }
	
	func mapping(map: Map) {
		cityId <- map[KEY_CITY_ID];
		countryId <- map[KEY_COUNTRY_ID];
		cityName <- map[KEY_CITY_NAME];
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: City.self);
	}
}
