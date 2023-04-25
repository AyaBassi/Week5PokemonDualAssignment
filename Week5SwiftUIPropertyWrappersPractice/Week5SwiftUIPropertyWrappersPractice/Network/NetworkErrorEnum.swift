//
//  NetworkError.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 25/04/2023.
//

import Foundation
enum NetworkErrorEnum :String{
    case dataNotFoundError
    case parsingError
    case invalidUrlError
}

extension NetworkErrorEnum : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataNotFoundError:return NSLocalizedString("API Failed to give data", comment: NetworkErrorEnum.dataNotFoundError.rawValue)
        case .parsingError: return NSLocalizedString("Failed to parse API", comment: NetworkErrorEnum.parsingError.rawValue)
        case .invalidUrlError: return NSLocalizedString("Invalid URL", comment: NetworkErrorEnum.invalidUrlError.rawValue)
        }
    }
}
