//
//  PagedScrollViewController.m
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "PagedScrollViewController.h"
#import "PostsTableViewController.h"
#import "Downloader.h"

static NSUInteger kNumberOfPages = 3;

@interface PagedScrollViewController () <UIScrollViewDelegate>

@end

@implementation PagedScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;

//    Downloader *downloader = [[Downloader alloc] init];
//    downloader.baseUrl = @"http://infinigag-us.aws.af.cm/hot/";
//    [downloader downloadWithCompletion:^(NSArray *posts, NSError *error) {
//        NSLog(@"%@", posts);
//    }];

}

- (void)viewDidAppear:(BOOL)animated {
    [self initScrollPages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initScrollPages {
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    unsigned pageNumber = 0;
    pageNumber = (int)kNumberOfPages;

    for (unsigned i = 0; i < pageNumber; i++) {
        PostsTableViewController *controller = [[PostsTableViewController alloc] initWithNibName:@"PostsTableViewController" bundle:nil];
        CGRect frame = _scrollView.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [_scrollView addSubview:controller.view];
        [controllers addObject:controller];
        [self addChildViewController:controller];
    }
    _viewControllers = controllers;
    _scrollView.pagingEnabled = YES;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    _scrollView.contentSize = CGSizeMake(screenBounds.size.width * pageNumber, screenBounds.size.height);
    _scrollView.delegate = self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = _scrollView.frame.size.width;
    _currentPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    ;
    PostsTableViewController *controller = [_viewControllers objectAtIndex:_currentPage];
    [controller.tableView flashScrollIndicators];
}

@end
