 //
 //  XCTHelper.swift
 //  UITesting
 //
 //  Created by Tal Zion on 22/03/2017.
 //  Copyright © 2017 Stanwood GmbH. All rights reserved.
 //
 
 import XCTest
 
 let Passed = (true, "")
 var Failed = (false, "")
 
 typealias TestsCompletion = (_ testCases: [UITesting.TestCase]) -> Void
 typealias Completion = () -> Void
 
 extension UITesting {
    
    class Helper {
        
        // MARK: Fetcher - Networking
        
        class open func fetchTestCases(withUrl url:URL, report: Report, completion: @escaping TestsCompletion) {
            
            Fetcher.sendRequest(with: url, URLParams: nil, HTTPMethod: .GET, headers: nil, body: nil, onCompletion: {
                dictionary, repsosne, error in
                
                var tests:[TestCase] = []
                
                if var dic = dictionary as? [String : Any], let testCases = dic["test_cases"] as? NSArray {
                    for testCase in testCases {
                        guard let testCaseDictionary = testCase as? [String:Any] else { continue }
                        do {
                            let test = try TestCase(testCase: testCaseDictionary)
                            
                            tests.append(test)
                        } catch UITesting.TestError.error(let error) {
                            report.test(failed: Failure(testID: error.id, navigationID: error.navigationIndex, message: error.message))
                        }
                    }
                    completion(tests)
                } else {
                    report.test(failed: Failure(message: "Failed to download test cases from: \(url). \nPlease check your bundle and version and make sure test cases were added."))
                    completion([])
                }
            })
        }
        
        // MARK: Dismissing Pop Ups
        
        class open func close(withApp app: XCUIApplication){
            let iconCloseButton = app.buttons["icon close"]
            if iconCloseButton.exists, iconCloseButton.isHittable {
                iconCloseButton.tap()
            }
        }

        class open func navigateToDefault(app:XCUIApplication){
            sleep(3)
            app.terminate()
            sleep(3)
            app.setupAndLaunch()
        }
    }
 }
