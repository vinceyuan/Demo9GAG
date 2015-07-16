//
//  Demo9GAGTests.m
//  Demo9GAGTests
//
//  Created by Vince Yuan on 15/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Downloader.h"

@interface Demo9GAGTests : XCTestCase

@end

@implementation Demo9GAGTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDownloader {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectations"];

    Downloader *downloader = [[Downloader alloc] init];
    downloader.baseUrl = @"http://infinigag-us.aws.af.cm/hot/";
    [downloader downloadWithCompletion:^(NSArray *posts, NSError *error) {
        NSLog(@"%@", posts);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
}

@end
