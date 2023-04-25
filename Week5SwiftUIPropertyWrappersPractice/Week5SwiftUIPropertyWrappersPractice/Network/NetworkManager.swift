//
//  NetworkManager.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 24/04/2023.
//

import Foundation
// Structures concurrency
class NetworkManager: NetworkableProtocol {
    
    
    func getDataFromAPI(url: URL) async throws -> Data {
        
        do{
            let (data,response) = try await URLSession.shared.data(from: url)
            print("Response: ",response)
            return data
        }catch {
            throw NetworkErrorEnum.dataNotFoundError
        }
    }
    
    
}
