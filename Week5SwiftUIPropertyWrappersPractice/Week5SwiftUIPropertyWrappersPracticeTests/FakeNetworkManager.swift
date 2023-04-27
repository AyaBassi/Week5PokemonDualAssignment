//
//  FakeNetworkManager.swift
//  Week5SwiftUIPropertyWrappersPracticeTests
//
//  Created by Payam Karbassi on 26/04/2023.
//

import Foundation
@testable import Week5SwiftUIPropertyWrappersPractice

class FakeNetworkManager: NetworkableProtocol {
    
    func getDataFromAPI(url: URL) async throws -> Data {
        let bundle = Bundle(for: FakeNetworkManager.self)
        
        guard let filePathUrl = bundle.url(forResource: url.absoluteString, withExtension: "json") else {
            throw NetworkErrorEnum.invalidUrlError
        }
        
        do {
            // Raw data still
            let data = try Data(contentsOf: filePathUrl)
            return data
        }catch {
            throw NetworkErrorEnum.dataNotFoundError
        }
    }
}
