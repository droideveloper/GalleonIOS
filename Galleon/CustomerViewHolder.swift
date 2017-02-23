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
 
import UIKit

import Core
import Material

class CustomerViewHolder: AbstractViewHolder<Customer>,
	LogDelegate {
	
	private let margin: CGFloat = 8;
	private let size: CGFloat		= 24;
	
	private var titleText: UILabel!;
	private var subTitleText: UILabel!;
	
	static let kIdentifier = "kCustomerViewHolder";
	
	override var item: Customer? {
		didSet {
			if let item = item {
				titleText.text = String(format: "%@%@%@", item.firstName ?? "", item.middleName ?? " ", item.lastName ?? "");
				subTitleText.text = item.identity;
			}
		}
	}
	
	override func prepare() {
		super.prepare();
		contentView.backgroundColor = .white;
		
		titleText = UILabel();
		titleText.numberOfLines = 1;
		titleText.font = RobotoFont.bold(with: 14);
		
		contentView.layout(titleText)
			.horizontally(left: margin, right: 2 * margin + size)
			.top(margin);
		
		subTitleText = UILabel();
		subTitleText.numberOfLines = 1;
		subTitleText.font = RobotoFont.light(with: 12);
		
		contentView.layout(subTitleText)
			.top(2 * margin + size)
			.horizontally(left: 8, right: 2 * margin + size);
		
		let imageView = UIImageView();
		imageView.image = Material.icon(.ic_arrow_forward)?
			.tint(with: Color.grey.darken2);
		
		contentView.layout(imageView)
			.size(CGSize(width: size, height: size))
			.right(margin)
			.centerVertically()
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: CustomerViewHolder.self);
	}
}

