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

class Document: NSObject,
	LogDelegate, Mappable {
	
	private let KEY_DOCUMENT_ID    = "DocumentID";
	private let KEY_DIRECTORY_ID   = "DirectoryID";
	private let KEY_CUSTOMER_ID    = "CustomerID";
	private let KEY_DOCUMENT_NAME  = "DocumentName";
	private let KEY_CONTENT_TYPE   = "ContentType";
	private let KEY_CONTENT_LENGTH = "ContentLength";
	private let KEY_CREATE_DATE    = "CreateDate";
	private let KEY_UPDATE_DATE    = "UpdateDate";
	
	var documentId: Int32?;
	var directoryId: Int32?;
	var customerId: Int32?;
	var documentName: String?;
	var contentType: String?;
	var contentLength: Int64?;
	var createDate: Date?;
	var updateDate: Date?;
	
	required init?(map: Map) { }
	
	func mapping(map: Map) {
		documentId <- map[KEY_DOCUMENT_ID];
		directoryId <- map[KEY_DIRECTORY_ID];
		customerId <- map[KEY_CUSTOMER_ID];
		documentName <- map[KEY_DOCUMENT_NAME];
		contentType <- map[KEY_CONTENT_TYPE];
		contentLength <- map[KEY_CONTENT_LENGTH];
		createDate <- map[KEY_CREATE_DATE];
		updateDate <- map[KEY_UPDATE_DATE];
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: Document.self);
	}
}
