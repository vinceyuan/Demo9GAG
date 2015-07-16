//
//  Demo9GAGTests.m
//  Demo9GAGTests
//
//  Created by Vince Yuan on 15/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Downloader.h"
#import "Post.h"

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
    // Download the first page
    [downloader downloadWithCompletion:^(NSArray *posts, NSError *error) {
        if (!error) {
            NSLog(@"%@", posts);
            // Check if we get posts
            XCTAssertNotNil(posts);
            XCTAssertNotEqual([posts count], 0);

            // Download the next page
            [downloader downloadWithCompletion:^(NSArray *posts2, NSError *error2) {
                if (!error2) {
                    NSLog(@"%@", posts2);
                    // Check if we get posts at the next page
                    XCTAssertNotNil(posts2);
                    XCTAssertNotEqual([posts2 count], 0);
                    [expectation fulfill];

                    // Check if the next page is different to the first page
                    XCTAssertNotEqual(((Post *)posts.firstObject).caption, ((Post *)posts2.firstObject).caption);
                }
            }];
        }
    }];
    [self waitForExpectationsWithTimeout:8.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
}

@end
