//
//  NetworkableProtocol.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 24/04/2023.
//

import Foundation
protocol NetworkableProtocol{
    func getDataFromAPI(url:URL) async throws -> Data
}
