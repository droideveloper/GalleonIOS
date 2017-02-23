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

import Alamofire

enum EndpointService {
	case createCustomer
	case createContact
	case createContacts
	case createDirectory
	case createDocuments
	
	case updateDocument
	
	case queryCustomers(String)
	case queryDirectory(Int32)
	case queryDocument(Int32)
	case queryDocumentsByDirectoryID(Int32)
	case queryCountries
	case queryCities(Int32)
	case queryCategories
	
	case tryLogin
	case tryKeepAlive
	
	var baseURL: String {
		return "http://192.168.1.105:52192";
	}

	var request: (method: Alamofire.HTTPMethod, url: URLConvertible) {
		switch self {
			case .tryLogin:
				return (method: .post, url: "\(baseURL)/v1/endpoint/sign-in");
			case .tryKeepAlive:
				return (method: .post, url: "\(baseURL)/v1/endpoint/keep-alive");
			case .queryCategories:
				return (method: .get, url: "\(baseURL)/v1/endpoint/categories");
			case .queryCities(let countryId):
				return (method: .get, url: "\(baseURL)/v1/endpoint/cities/\(countryId)");
			case .queryCountries:
				return (method: .get, url: "\(baseURL)/v1/endpoint/countries");
			case .queryDocumentsByDirectoryID(let directoryId):
				return (method: .get, url: "\(baseURL)/v1/endpoint/documents/\(directoryId)");
			case .queryDocument(let documentId):
				return (method: .get, url: "\(baseURL)/v1/endpoint/document/\(documentId)");
			case .queryDirectory(let directoryId):
				return (method: .get, url: "\(baseURL)/v1/endpoint/directory/\(directoryId)");
			case .queryCustomers(let query):
				return (method: .post, url: "\(baseURL)/v1/endpoint/customers-query/\(query)");
			case .updateDocument:
				return (method: .post, url: "\(baseURL)/v1/endpoint/update/document");
			case .createDocuments:
				return (method: .post, url: "\(baseURL)/v1/endpoint/create/documents");
			case .createCustomer:
				return (method: .post, url: "\(baseURL)/v1/endpoint/create/customer");
			case .createContact:
				return (method: .post, url: "\(baseURL)/v1/endpoint/create/contact");
			case .createContacts:
				return (method: .post, url: "\(baseURL)/v1/endpoint/create/contacts");
			case .createDirectory:
				return (method: .post, url: "\(baseURL)/v1/endpoint/create/directory");
		}
	}
}
