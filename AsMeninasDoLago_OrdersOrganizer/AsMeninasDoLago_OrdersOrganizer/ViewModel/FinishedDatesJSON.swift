//
//  FinishedDatesJSON.swift
//  AsMeninasDoLago_OrdersOrganizer
//
//  Created by Rodrigo Ryo Aoki on 03/11/21.
//

import Foundation

struct FinishedDatesJSON: Decodable, Hashable  {
	var dateTitle: String?
	var finishedOrders: [OrderJSON]?
}
