//
//  AppListDTO.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/22.
//

import Foundation

// MARK: - Welcome
struct AppListDTO: Codable {
    let resultCount: Int
    let results: [AppInfoDTO]
}

// MARK: - AppInfoDTO
struct AppInfoDTO: Codable {
    let screenshotUrls, ipadScreenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let features: [Feature]
    let supportedDevices, advisories: [String]
    let isGameCenterEnabled: Bool
    let kind: Kind
    let minimumOSVersion, trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let sellerURL: String?
    let contentAdvisoryRating: Rating
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String
    let trackContentRating: Rating
    let releaseNotes, bundleID: String
    let currentVersionReleaseDate: String
    let trackID: Int
    let trackName: String
    let releaseDate: String
    let primaryGenreName: String
    let genreIDS: [String]
    let isVppDeviceBasedLicensingEnabled: Bool
    let sellerName: String
    let primaryGenreID: Int
    let currency: Currency
    let resultDescription: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let version: String
    let wrapperType: Kind
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case screenshotUrls, ipadScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case features, supportedDevices, advisories, isGameCenterEnabled, kind
        case minimumOSVersion = "minimumOsVersion"
        case trackCensoredName, languageCodesISO2A, fileSizeBytes
        case sellerURL = "sellerUrl"
        case contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating, releaseNotes
        case bundleID = "bundleId"
        case currentVersionReleaseDate
        case trackID = "trackId"
        case trackName, releaseDate, primaryGenreName
        case genreIDS = "genreIds"
        case isVppDeviceBasedLicensingEnabled, sellerName
        case primaryGenreID = "primaryGenreId"
        case currency
        case resultDescription = "description"
        case artistID = "artistId"
        case artistName, genres, version, wrapperType, userRatingCount
    }
}

enum Rating: String, Codable {
    case the17 = "17+"
    case the12 = "12+"
    case the4 = "4+"
    case the9 = "9+"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Feature: String, Codable {
    case iosUniversal = "iosUniversal"
}

enum FormattedPrice: String, Codable {
    case free = "Free"
}

enum Kind: String, Codable {
    case software = "software"
}

// MARK: - Encode/decode helpers

// class JSONNull: Codable, Hashable {
//
//     public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//         return true
//     }
//
//     public var hashValue: Int {
//         return 0
//     }
//
//     public init() {}
//
//     public required init(from decoder: Decoder) throws {
//         let container = try decoder.singleValueContainer()
//         if !container.decodeNil() {
//             throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//         }
//     }
//
//     public func encode(to encoder: Encoder) throws {
//         var container = encoder.singleValueContainer()
//         try container.encodeNil()
//     }
// }

// class JSONCodingKey: CodingKey {
//     let key: String
//
//     required init?(intValue: Int) {
//         return nil
//     }
//
//     required init?(stringValue: String) {
//         key = stringValue
//     }
//
//     var intValue: Int? {
//         return nil
//     }
//
//     var stringValue: String {
//         return key
//     }
// }
//
// class JSONAny: Codable {
//
//     let value: Any
//
//     static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//         let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//         return DecodingError.typeMismatch(JSONAny.self, context)
//     }
//
//     static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//         let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//         return EncodingError.invalidValue(value, context)
//     }
//
//     static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//         if let value = try? container.decode(Bool.self) {
//             return value
//         }
//         if let value = try? container.decode(Int64.self) {
//             return value
//         }
//         if let value = try? container.decode(Double.self) {
//             return value
//         }
//         if let value = try? container.decode(String.self) {
//             return value
//         }
//         if container.decodeNil() {
//             return JSONNull()
//         }
//         throw decodingError(forCodingPath: container.codingPath)
//     }
//
//     static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
//         if let value = try? container.decode(Bool.self) {
//             return value
//         }
//         if let value = try? container.decode(Int64.self) {
//             return value
//         }
//         if let value = try? container.decode(Double.self) {
//             return value
//         }
//         if let value = try? container.decode(String.self) {
//             return value
//         }
//         if let value = try? container.decodeNil() {
//             if value {
//                 return JSONNull()
//             }
//         }
//         if var container = try? container.nestedUnkeyedContainer() {
//             return try decodeArray(from: &container)
//         }
//         if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
//             return try decodeDictionary(from: &container)
//         }
//         throw decodingError(forCodingPath: container.codingPath)
//     }
//
//     static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
//         if let value = try? container.decode(Bool.self, forKey: key) {
//             return value
//         }
//         if let value = try? container.decode(Int64.self, forKey: key) {
//             return value
//         }
//         if let value = try? container.decode(Double.self, forKey: key) {
//             return value
//         }
//         if let value = try? container.decode(String.self, forKey: key) {
//             return value
//         }
//         if let value = try? container.decodeNil(forKey: key) {
//             if value {
//                 return JSONNull()
//             }
//         }
//         if var container = try? container.nestedUnkeyedContainer(forKey: key) {
//             return try decodeArray(from: &container)
//         }
//         if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
//             return try decodeDictionary(from: &container)
//         }
//         throw decodingError(forCodingPath: container.codingPath)
//     }
//
//     static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
//         var arr: [Any] = []
//         while !container.isAtEnd {
//             let value = try decode(from: &container)
//             arr.append(value)
//         }
//         return arr
//     }
//
//     static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
//         var dict = [String: Any]()
//         for key in container.allKeys {
//             let value = try decode(from: &container, forKey: key)
//             dict[key.stringValue] = value
//         }
//         return dict
//     }
//
//     static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
//         for value in array {
//             if let value = value as? Bool {
//                 try container.encode(value)
//             } else if let value = value as? Int64 {
//                 try container.encode(value)
//             } else if let value = value as? Double {
//                 try container.encode(value)
//             } else if let value = value as? String {
//                 try container.encode(value)
//             } else if value is JSONNull {
//                 try container.encodeNil()
//             } else if let value = value as? [Any] {
//                 var container = container.nestedUnkeyedContainer()
//                 try encode(to: &container, array: value)
//             } else if let value = value as? [String: Any] {
//                 var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
//                 try encode(to: &container, dictionary: value)
//             } else {
//                 throw encodingError(forValue: value, codingPath: container.codingPath)
//             }
//         }
//     }
//
//     static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
//         for (key, value) in dictionary {
//             let key = JSONCodingKey(stringValue: key)!
//             if let value = value as? Bool {
//                 try container.encode(value, forKey: key)
//             } else if let value = value as? Int64 {
//                 try container.encode(value, forKey: key)
//             } else if let value = value as? Double {
//                 try container.encode(value, forKey: key)
//             } else if let value = value as? String {
//                 try container.encode(value, forKey: key)
//             } else if value is JSONNull {
//                 try container.encodeNil(forKey: key)
//             } else if let value = value as? [Any] {
//                 var container = container.nestedUnkeyedContainer(forKey: key)
//                 try encode(to: &container, array: value)
//             } else if let value = value as? [String: Any] {
//                 var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
//                 try encode(to: &container, dictionary: value)
//             } else {
//                 throw encodingError(forValue: value, codingPath: container.codingPath)
//             }
//         }
//     }
//
//     static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
//         if let value = value as? Bool {
//             try container.encode(value)
//         } else if let value = value as? Int64 {
//             try container.encode(value)
//         } else if let value = value as? Double {
//             try container.encode(value)
//         } else if let value = value as? String {
//             try container.encode(value)
//         } else if value is JSONNull {
//             try container.encodeNil()
//         } else {
//             throw encodingError(forValue: value, codingPath: container.codingPath)
//         }
//     }
//
//     public required init(from decoder: Decoder) throws {
//         if var arrayContainer = try? decoder.unkeyedContainer() {
//             self.value = try JSONAny.decodeArray(from: &arrayContainer)
//         } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
//             self.value = try JSONAny.decodeDictionary(from: &container)
//         } else {
//             let container = try decoder.singleValueContainer()
//             self.value = try JSONAny.decode(from: container)
//         }
//     }
//
//     public func encode(to encoder: Encoder) throws {
//         if let arr = self.value as? [Any] {
//             var container = encoder.unkeyedContainer()
//             try JSONAny.encode(to: &container, array: arr)
//         } else if let dict = self.value as? [String: Any] {
//             var container = encoder.container(keyedBy: JSONCodingKey.self)
//             try JSONAny.encode(to: &container, dictionary: dict)
//         } else {
//             var container = encoder.singleValueContainer()
//             try JSONAny.encode(to: &container, value: self.value)
//         }
//     }
// }
