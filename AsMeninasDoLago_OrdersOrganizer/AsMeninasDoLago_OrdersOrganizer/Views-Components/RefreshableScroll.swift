//
//  RefreshableScroll.swift
//  AsMeninasDoLago
//
//  Created by Rodrigo Ryo Aoki on 26/11/21.
//

import SwiftUI

struct RefreshableScroll<Content: View>: UIViewRepresentable {
	var content: Content
	var onRefresh: (UIRefreshControl) -> ()
	var refreshControll = UIRefreshControl()
	
	init(@ViewBuilder content: @escaping () -> Content, onRefresh: @escaping (UIRefreshControl) -> ()) {
		self.content = content()
		self.onRefresh = onRefresh
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(parent: self)
	}
	
	func makeUIView(context: Context) -> UIScrollView {
		let scroll = UIScrollView()
		
		setupView(scroll: scroll)
		refreshControll.addTarget(context.coordinator, action: #selector(context.coordinator.onRefresh), for: .valueChanged)
		
		scroll.refreshControl = refreshControll
		
		return scroll
	}
	
	func updateUIView(_ uiView: UIScrollView, context: Context) {
		
	}
	
	func setupView(scroll: UIScrollView) {
		let hostView = UIHostingController(rootView: content)
		hostView.view.translatesAutoresizingMaskIntoConstraints = false
		
		let constraints = [
			hostView.view.topAnchor.constraint(equalTo: scroll.topAnchor),
			hostView.view.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
			hostView.view.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
			hostView.view.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
			
			hostView.view.widthAnchor.constraint(equalTo: scroll.widthAnchor),
			hostView.view.heightAnchor.constraint(greaterThanOrEqualTo: scroll.heightAnchor)
		]
		scroll.subviews.last?.removeFromSuperview()
		scroll.addSubview(hostView.view)
		scroll.addConstraints(constraints)
	}
	
	class Coordinator: NSObject {
		var parent: RefreshableScroll
		
		init(parent: RefreshableScroll) {
			self.parent = parent
		}
		
		@objc func onRefresh() {
			parent.onRefresh(parent.refreshControll)
		}
	}
}
