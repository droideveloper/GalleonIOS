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

class ResponseObject<T: Mappable>: NSObject,
	LogDelegate, Mappable {
	
	private let KEY_CODE			= "Code";
	private let KEY_MESSAGE		= "Message";
	private let KEY_DATA			= "Data";
	
	var code: Int?;
	var message: String?;
	var data: T?;
	
	required init?(map: Map) { }
	
	func mapping(map: Map) {
		code <- map[KEY_CODE];
		message <- map[KEY_MESSAGE];
		data <- map[KEY_DATA];
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: ResponseObject.self);
	}
}

class ResponseArray<T: Mappable>: NSObject,
	LogDelegate, Mappable {
	
	private let KEY_CODE			= "Code";
	private let KEY_MESSAGE		= "Message";
	private let KEY_DATA			= "Data";
	
	var code: Int?;
	var message: String?;
	var data: [T]?;
	
	required init?(map: Map) { }
	
	func mapping(map: Map) {
		code <- map[KEY_CODE];
		message <- map[KEY_MESSAGE];
		data <- map[KEY_DATA];
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: ResponseArray.self);
	}
}

class ResponsePrimitive<T>: NSObject,
	LogDelegate, Mappable {
	
	private let KEY_CODE			= "Code";
	private let KEY_MESSAGE		= "Message";
	private let KEY_DATA			= "Data";
	
	var code: Int?;
	var message: String?;
	var data: T?;
	
	required init?(map: Map) { }
	
	func mapping(map: Map) {
		code <- map[KEY_CODE];
		message <- map[KEY_MESSAGE];
		data <- map[KEY_DATA];
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: ResponsePrimitive.self);
	}
}
