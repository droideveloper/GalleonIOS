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

import RxSwift

protocol IEndpoint {
	
	func tryLogin(credential: Credential) -> Observable<ResponseObject<Session>>;
	func tryKeepAlive(token: String) -> Observable<ResponseObject<Session>>;
	
	func queryCategories() -> Observable<ResponseArray<Category>>;
	func queryCities(countryId: Int32) -> Observable<ResponseArray<City>>;
	func queryCountries() -> Observable<ResponseArray<Country>>;
	func queryDocumentsByDirectoryID(directoryId: Int32) -> Observable<ResponseArray<Document>>;
	func queryDocument(documentId: Int32) -> Observable<ResponseObject<Document>>;
	func queryDirectory(directoryId: Int32) -> Observable<ResponseObject<Directory>>;
	func queryCustomers(query: String) -> Observable<ResponseArray<Customer>>;
	
	func updateDocument(document: Document) -> Observable<ResponseObject<Document>>;
	
	func createDocuments(documents: [Document]) -> Observable<ResponseArray<Document>>;
	func createCustomer(customer: Customer) -> Observable<ResponseObject<Customer>>;
	func createContact(contact: Contact) -> Observable<ResponseObject<Contact>>;
	func createContacts(contacts: [Contact]) -> Observable<ResponseArray<Contact>>;
	func createDirectory(directory: Directory) -> Observable<ResponseObject<Directory>>;
}
