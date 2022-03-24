//
//  SearchServiceTests.swift
//  appStoreSearchAppTests
//
//  Created by 박지찬 on 2022/03/22.
//

import XCTest
import RxBlocking
@testable import appStoreSearchApp

class SearchServiceTests: XCTestCase {
    var service: SearchService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = SearchService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        service = nil
    }
    
    func testLoadSearch() throws {
        let dto = try service.loadList(term: "apple")
            .asObservable()
            .toBlocking(timeout: 10)
            .first()
        
        XCTAssertNotNil(dto)
    }
}
