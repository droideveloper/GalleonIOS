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

class NavigationViewHolder: AbstractViewHolder<Navigation> {
	
	static let kIdentifier = "kNavigationViewHolder";
	
	override var item: Navigation? {
		didSet {
			if let entity = item {
				if let iconName = entity.image {
					icon.image = Material.icon(iconName);
				}
				title.text = entity.title;
			}
		}
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated);
		if selected {
			icon.tintColor = selectedColor;
			title.textColor = selectedColor;
			contentView.backgroundColor = selectedBackgroundColor;
		} else  {
			icon.tintColor = notSelectedColor;
			title.textColor = notSelectedColor;
			contentView.backgroundColor = notSelectedBackgroundColor;
		}
	}
	
	public var selectedColor: UIColor? = Color.pink.base;
	public var notSelectedColor: UIColor? = Color.white;
	
	public var notSelectedBackgroundColor: UIColor? = Color.grey.darken3;
	public var selectedBackgroundColor: UIColor? = Color.grey.darken4;
	
	private var title: UILabel!;
	private var icon: UIImageView!;
	
	override func prepare() {
		super.prepare();
		contentView.backgroundColor = .clear;
		
		icon = UIImageView();
		
		contentView.layout(icon)
			.left(8)
			.centerVertically();
		
		title = UILabel();
		title.numberOfLines = 1;
		title.font = RobotoFont.light(with: 15);
		
		contentView.layout(title)
			.horizontally(left: 40, right: 8)
			.centerVertically();
	}
	
	func isLogEnabled() -> Bool {
		return true;
	}
	
	func getClassTag() -> String {
		return String(describing: NavigationViewHolder.self);
	}
}
