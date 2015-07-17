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

    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Hot", @"Trending", @"Fresh"]];
    self.navigationItem.titleView = _segmentedControl;
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(segmentedControlValueChanged) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.tintColor = [UIColor whiteColor];
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
        switch (i) {
            case 0:
                controller.downloader.baseUrl = @"http://infinigag-us.aws.af.cm/hot/";
                break;
            case 1:
                controller.downloader.baseUrl = @"http://infinigag-us.aws.af.cm/trending/";
                break;
            case 2:
                controller.downloader.baseUrl = @"http://infinigag-us.aws.af.cm/fresh/";
                break;
            default:
                break;
        }
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
    CGRect scrollViewBounds = _scrollView.bounds;
    _scrollView.contentSize = CGSizeMake(scrollViewBounds.size.width * pageNumber, scrollViewBounds.size.height);
    _scrollView.delegate = self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = _scrollView.frame.size.width;
    _currentPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    ;
    PostsTableViewController *controller = [_viewControllers objectAtIndex:_currentPage];
    [controller.tableView flashScrollIndicators];
    _segmentedControl.selectedSegmentIndex = _currentPage;
}

- (void)segmentedControlValueChanged {
    _currentPage = (int)_segmentedControl.selectedSegmentIndex;
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * _currentPage;
    [_scrollView scrollRectToVisible:frame animated:YES];
}
@end
