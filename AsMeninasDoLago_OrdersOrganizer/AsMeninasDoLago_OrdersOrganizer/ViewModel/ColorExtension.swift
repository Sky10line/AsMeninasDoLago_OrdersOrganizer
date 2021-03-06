//
//  ColorExtension.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 13/10/21.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
	static var appBrown = UIColor(red: 0.412, green: 0.204, blue: 0.059, alpha: 1)
	static var appGreen = UIColor(red: 0.133, green: 0.678, blue: 0.506, alpha: 1)
	static var gray1 = UIColor(red: 0.584, green: 0.584, blue: 0.58, alpha: 1)
	static var gray2 = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
	static var gray3 = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
	static var defaultPlaceholder = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
}

extension ScrollView {
	
	public func fixFlickering() -> some View {
		
		return self.fixFlickering { (scrollView) in
			
			return scrollView
		}
	}
	
	public func fixFlickering<T: View>(@ViewBuilder configurator: @escaping (ScrollView<AnyView>) -> T) -> some View {
		
		GeometryReader { geometryWithSafeArea in
			GeometryReader { geometry in
				configurator(
				ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
					AnyView(
					VStack {
						self.content
					}
					.padding(.top, geometryWithSafeArea.safeAreaInsets.top)
					.padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
					.padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
					.padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
					)
				}
				)
			}
			.edgesIgnoringSafeArea(.all)
		}
	}
}
