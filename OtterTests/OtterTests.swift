//
//  OtterTests.swift
//  OtterTests
//
//  Created by Anthony Dejbox on 24/02/2020.
//  Copyright © 2020 Anthony Pauriche. All rights reserved.
//

import XCTest
@testable import Otter

class OtterTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testLogCount() {
        let string = """
            [otter]
            10:24:02.980 [ POST ] https://frontoffice-middle-staging.dejbox.io/app/v1/signin/refreshtoken
            Body: eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2Vycy9kYmI0NWMzNy03NWU4LTRkMzMtYmU5NC00ZDBlYTEzMDcwZWIiLCJleHAiOjE1ODUxMjgxNzIsIm5hbWUiOiJzc3NzZiIsInNjb3BlIjoiQ1VTVE9NRVIiLCJyYW5kb20iOiIxNDU5MzIyODUxIn0.rfsCRmlnFzAt8Q5GJ_Me98NMuRSGIPJig0fCLzxsRnQ
            Result (JSON): 200 - {
              "refresh_token" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2Vycy9kYmI0NWMzNy03NWU4LTRkMzMtYmU5NC00ZDBlYTEzMDcwZWIiLCJleHAiOjE1ODUxMjgyNDIsIm5hbWUiOiJzc3NzZiIsInNjb3BlIjoiQ1VTVE9NRVIiLCJyYW5kb20iOiItMzU1Mzg3MjkyIn0.DyTCgsR5jTeU-Fo7ySlVPnD0KEIepzSijvKeS4Hn59M",
              "expiration_access" : "2020-02-24T09:54:02.963312Z",
              "expiration_refresh" : "2020-03-25T09:24:02.963319Z",
              "access_token" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2Vycy9kYmI0NWMzNy03NWU4LTRkMzMtYmU5NC00ZDBlYTEzMDcwZWIiLCJleHAiOjE1ODI1MzgwNDIsIm5hbWUiOiJzc3NzZiIsInNjb3BlIjoiQ1VTVE9NRVIiLCJyYW5kb20iOiItMzE0NzAyNDg3In0.Me4GXiA6fRZ4-FYIpY0keELKq6fF8jQ1JLIROIm-Ax4",
              "uuid" : "28ae5a85-7134-45f9-8d3c-ec71ec94d34f"
            }
            [/otter]
            [otter]
            10:24:02.980 [ POST ] https://frontoffice-middle-staging.dejbox.io/app/v1/signin/refreshtoken
            Body: eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2Vycy9kYmI0NWMzNy03NWU4LTRkMzMtYmU5NC00ZDBlYTEzMDcwZWIiLCJleHAiOjE1ODUxMjgxNzIsIm5hbWUiOiJzc3NzZiIsInNjb3BlIjoiQ1VTVE9NRVIiLCJyYW5kb20iOiIxNDU5MzIyODUxIn0.rfsCRmlnFzAt8Q5GJ_Me98NMuRSGIPJig0fCLzxsRnQ
            Result (JSON): 200 - {
              "refresh_token" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2Vycy9kYmI0NWMzNy03NWU4LTRkMzMtYmU5NC00ZDBlYTEzMDcwZWIiLCJleHAiOjE1ODUxMjgyNDIsIm5hbWUiOiJzc3NzZiIsInNjb3BlIjoiQ1VTVE9NRVIiLCJyYW5kb20iOiItMzU1Mzg3MjkyIn0.DyTCgsR5jTeU-Fo7ySlVPnD0KEIepzSijvKeS4Hn59M",
              "expiration_access" : "2020-02-24T09:54:02.963312Z",
              "expiration_refresh" : "2020-03-25T09:24:02.963319Z",
              "access_token" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2Vycy9kYmI0NWMzNy03NWU4LTRkMzMtYmU5NC00ZDBlYTEzMDcwZWIiLCJleHAiOjE1ODI1MzgwNDIsIm5hbWUiOiJzc3NzZiIsInNjb3BlIjoiQ1VTVE9NRVIiLCJyYW5kb20iOiItMzE0NzAyNDg3In0.Me4GXiA6fRZ4-FYIpY0keELKq6fF8jQ1JLIROIm-Ax4",
              "uuid" : "28ae5a85-7134-45f9-8d3c-ec71ec94d34f"
            [/otter]
            }
        """
        
        let logs = LogParser().generateLogs(string: string)
        XCTAssertEqual(logs.count, 2)
    }
    
    func testLogCountWithSpaceInsideLog() {
        let string = """

            [otter]

            [/otter]

        """
        
        let logs = LogParser().generateLogs(string: string)
        XCTAssertEqual(logs.count, 1)
    }
    
    func testLogCountWithOpenTagInsideLog() {
        let string = """
            [otter]
            [otter]
            [/otter]
            }
        """
        
        let logs = LogParser().generateLogs(string: string)
        XCTAssertEqual(logs.count, 1)
    }
    
    func testLogCountWithCloseTagInsideLog() {
        let string = """
            [otter]
            [/otter]
            [/otter]
            }
        """
        
        let logs = LogParser().generateLogs(string: string)
        XCTAssertEqual(logs.count, 1)
    }
    
    func testColor() {
        let string = """
        [otter color="ff0000"]
        bla bla
        [/otter]
        """
        
        let logs = LogParser().generateLogs(string: string)
        
        XCTAssert(logs.count == 1)
        
        XCTAssertEqual(true, logs.first?.params.contains(Log.Parameter.color(string: "ff0000")))
    }

    func testLogSearch() {
        let string = """
        [otter color="ff0000"]
        bla bla
        [/otter]
        [otter color="ff0000"]
        bla blou
        [/otter]
        """
        
        let logs = LogParser().generateLogs(string: string)
        let filteredLogs = LogParser().search(query: "blou", in: logs)
        XCTAssertEqual(filteredLogs.count, 1)
    }
    
    func testLogSearchEmpty() {
        let string = """
        [otter color="ff0000"]
        bla bla
        [/otter]
        [otter color="ff0000"]
        bla blou
        [/otter]
        """
        
        let logs = LogParser().generateLogs(string: string)
        let filteredLogs = LogParser().search(query: "", in: logs)
        XCTAssertEqual(filteredLogs.count, 2)
    }
    
}
