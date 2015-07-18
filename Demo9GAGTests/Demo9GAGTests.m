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

- (void)testParsingPost {
    NSString *jsonString = @"{\
    \"id\": \"aBrweKP\",\
    \"from\": {\
        \"name\": \"\"\
    },\
    \"caption\": \"When I read about the beliefs of Scientologists\",\
    \"images\": {\
        \"small\": \"\",\
        \"normal\": \"http:\\/\\/img-9gag-fun.9cache.com\\/photo\\/aBrweKP_460s.jpg\",\
        \"large\": \"http:\\/\\/img-9gag-fun.9cache.com\\/photo\\/aBrweKP_700b.jpg\"\
    },\
    \"link\": \"http:\\/\\/9gag.com\\/gag\\/aBrweKP\",\
    \"actions\": {\
        \"like\": \"http:\\/\\/9gag.com\\/vote\\/like\\/id\\/aBrweKP\",\
        \"dislike\": \"http:\\/\\/9gag.com\\/vote\\/dislike\\/id\\/aBrweKP\",\
        \"unlike\": \"http:\\/\\/9gag.com\\/vote\\/unlike\\/id\\/aBrweKP\"\
    },\
    \"votes\": {\
        \"count\": 8474\
    }\
    }";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&e];
    Post *post = [[Post alloc] init];
    [post parseJSON:dict];
    XCTAssertEqualObjects(post.postId, @"aBrweKP");
    XCTAssertEqualObjects(post.caption, @"When I read about the beliefs of Scientologists");
    XCTAssertEqualObjects([post.imageUrl absoluteString], @"http://img-9gag-fun.9cache.com/photo/aBrweKP_460s.jpg");
    XCTAssertEqualObjects(post.link, @"http://9gag.com/gag/aBrweKP");
    XCTAssertEqual(post.voteCount, 8474);
}

- (void)testDownloader {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectations"];

    Downloader *downloader = [[Downloader alloc] init];
    downloader.baseUrl = @"http://infinigag-us.aws.af.cm/hot/";
    // Download the first page
    [downloader downloadWithCompletion:^(NSArray *posts, NSError *error) {
        if (!error) {
            //NSLog(@"%@", posts);
            // Check if we get posts
            XCTAssertNotNil(posts);
            XCTAssertNotEqual([posts count], 0);

            // Download the next page
            [downloader downloadWithCompletion:^(NSArray *posts2, NSError *error2) {
                if (!error2) {
                    //NSLog(@"%@", posts2);
                    // Check if we get posts at the next page
                    XCTAssertNotNil(posts2);
                    XCTAssertNotEqual([posts2 count], 0);
                    [expectation fulfill];

                    // Check if the next page is different to the first page
                    XCTAssertNotEqualObjects(((Post *)posts.firstObject).caption, ((Post *)posts2.firstObject).caption);
                } else {
                    NSLog(@"Error in downloading next page: %@", error2);
                }
            }];
        } else {
            NSLog(@"Error in downloading first page: %@", error);
        }
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
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
