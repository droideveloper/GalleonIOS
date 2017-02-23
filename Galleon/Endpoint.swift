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
import RxSwift

import Alamofire
import ObjectMapper

class Endpoint: IEndpoint {

	var preferences: IPreferenceManager?;
	private let kAuthToken = "X-Auth-Token";
	
	func tryLogin(credential: Credential) -> Observable<ResponseObject<Session>> {
		let request = EndpointService.tryLogin.request;
		return RxNet.object(request.method, request.url, parameters: credential.toJSON(), encoding: JSONEncoding.default);
	}
	
	func tryKeepAlive(token: String) -> Observable<ResponseObject<Session>> {
		let request = EndpointService.tryKeepAlive.request;
		return RxNet.object(request.method, request.url, parameters: ["rawValue": token], encoding: JSONRawValueEncoding.default);
	}
	
	func queryCategories() -> Observable<ResponseArray<Category>> {
		let request = EndpointService.queryCategories.request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: nil, encoding: URLEncoding.default, headers: headers);
	}
	
	func queryCities(countryId: Int32) -> Observable<ResponseArray<City>> {
		let request = EndpointService.queryCities(countryId).request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: nil, encoding: URLEncoding.default, headers: headers);
	}
	
	func queryCountries() -> Observable<ResponseArray<Country>> {
		let request = EndpointService.queryCountries.request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: nil, encoding: URLEncoding.default, headers: headers);
	}
	
	func queryDocumentsByDirectoryID(directoryId: Int32) -> Observable<ResponseArray<Document>> {
		let request = EndpointService.queryDocumentsByDirectoryID(directoryId).request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: nil, encoding: URLEncoding.default, headers: headers);
	}
	
	func queryDocument(documentId: Int32) -> Observable<ResponseObject<Document>> {
		let request = EndpointService.queryDocument(documentId).request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: nil, encoding: URLEncoding.default, headers: headers);
	}
	
	func queryDirectory(directoryId: Int32) -> Observable<ResponseObject<Directory>> {
		let request = EndpointService.queryDirectory(directoryId).request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: nil, encoding: URLEncoding.default, headers: headers);
	}
	
	func queryCustomers(query: String) -> Observable<ResponseArray<Customer>> {
		let request = EndpointService.queryCustomers(query).request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: nil, encoding: URLEncoding.default, headers: headers);
	}
	
	func updateDocument(document: Document) -> Observable<ResponseObject<Document>> {
		let request = EndpointService.updateDocument.request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: document.toJSON(), encoding: JSONEncoding.default, headers: headers);
	}
	
	func createDocuments(documents: [Document]) -> Observable<ResponseArray<Document>> {
		let request = EndpointService.createDocuments.request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: documents.toJSON(), encoding: JSONArrayEncoding.default, headers: headers);
	}
	
	func createCustomer(customer: Customer) -> Observable<ResponseObject<Customer>> {
		let request = EndpointService.createCustomer.request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: customer.toJSON(), encoding: JSONEncoding.default, headers: headers);
	}
	
	func createContact(contact: Contact) -> Observable<ResponseObject<Contact>> {
		let request = EndpointService.createContact.request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: contact.toJSON(), encoding: JSONEncoding.default, headers: headers);
	}
	
	func createContacts(contacts: [Contact]) -> Observable<ResponseArray<Contact>> {
		let request = EndpointService.createContacts.request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: contacts.toJSON(), encoding: JSONArrayEncoding.default, headers: headers);
	}
	
	func createDirectory(directory: Directory) -> Observable<ResponseObject<Directory>> {
		let request = EndpointService.createDirectory.request;
		var headers: [String: String] = [:];
		headers[kAuthToken] = preferences?.token;
		return RxNet.object(request.method, request.url, parameters: directory.toJSON(), encoding: JSONEncoding.default, headers: headers);
	}
}
