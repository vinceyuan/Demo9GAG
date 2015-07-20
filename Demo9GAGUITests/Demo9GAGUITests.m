//
//  Demo9GAGUITests.m
//  Demo9GAGUITests
//
//  Created by Vince Yuan on 15/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Demo9GAGUITests : XCTestCase

@end

@implementation Demo9GAGUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testScrolling {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    XCUIApplication *application = [[XCUIApplication alloc] init];

    XCTAssertEqual([application.scrollViews count], 1);

    XCUIElement *scrollView = [application.scrollViews elementBoundByIndex:0];
    [scrollView swipeLeft];
    [scrollView swipeLeft];
    [scrollView swipeRight];
    [scrollView swipeRight];

    XCUIElement *pagedscrollviewNavigationBar = application.navigationBars[@"PagedScrollView"];
    XCUIElement *segmentedControl = [pagedscrollviewNavigationBar.segmentedControls elementBoundByIndex:0];
    NSLog(@"%@", [segmentedControl debugDescription]);

    [pagedscrollviewNavigationBar.buttons[@"Trending"] tap];
    [pagedscrollviewNavigationBar.buttons[@"Fresh"] tap];
    [pagedscrollviewNavigationBar.buttons[@"Hot"] tap];


    XCUIElement *tableView = [application.tables elementBoundByIndex:0];

    [tableView swipeDown];
    [tableView swipeUp];
    [tableView swipeUp];
    [tableView swipeUp];
    [tableView swipeUp];
    [tableView swipeUp];
    [tableView swipeUp];
    [tableView swipeUp];
    [tableView swipeUp];

    [pagedscrollviewNavigationBar.buttons[@"Clear"] tap];

    [tableView swipeUp];
    [tableView swipeUp];
    [tableView swipeUp];
    [tableView swipeDown];
    [tableView swipeDown];

}

@end
