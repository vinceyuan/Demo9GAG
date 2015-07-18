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
#import "TopPostsTableViewController.h"
#import "SDImageCache.h"

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

    [self clearImageCache];
}

- (void)clearImageCache {
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
}

- (void)initScrollPages {
    CGRect scrollViewBounds = _scrollView.bounds;
    CGFloat width = scrollViewBounds.size.width;
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    unsigned pageNumber = 0;
    pageNumber = (int)kNumberOfPages;

    for (unsigned i = 0; i < pageNumber; i++) {
        PostsTableViewController *controller = [[PostsTableViewController alloc] initWithNibName:@"PostsTableViewController" bundle:nil];
        switch (i) {
            case 0:
            {
                controller.downloader.baseUrl = @"http://infinigag-us.aws.af.cm/hot/";

                TopPostsTableViewController *topPostsCtrl = [[TopPostsTableViewController alloc] initWithNibName:@"TopPostsTableViewController" bundle:nil];
                topPostsCtrl.tableView.scrollsToTop = NO;
                UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, TopPostsTableViewCellWidth)];
                [headerView addSubview:topPostsCtrl.view];
                topPostsCtrl.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
                topPostsCtrl.view.frame = CGRectMake(0, 0, width, TopPostsTableViewCellWidth);
                controller.tableView.tableHeaderView = headerView;
                [controller addChildViewController:topPostsCtrl];
                controller.tableView.scrollsToTop = YES;
                break;
            }
            case 1:
                controller.downloader.baseUrl = @"http://infinigag-us.aws.af.cm/trending/";
                controller.tableView.scrollsToTop = NO;
                break;
            case 2:
                controller.downloader.baseUrl = @"http://infinigag-us.aws.af.cm/fresh/";
                controller.tableView.scrollsToTop = NO;
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
    _scrollView.contentSize = CGSizeMake(scrollViewBounds.size.width * pageNumber, scrollViewBounds.size.height);
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = _scrollView.frame.size.width;
    _currentPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    ;
    for (int i = 0; i < 3; i++) {
        PostsTableViewController *ctrl = [_viewControllers objectAtIndex:i];
        ctrl.tableView.scrollsToTop = NO;
    }
    PostsTableViewController *controller = [_viewControllers objectAtIndex:_currentPage];
    [controller.tableView flashScrollIndicators];
    controller.tableView.scrollsToTop = YES;
    _segmentedControl.selectedSegmentIndex = _currentPage;
}

- (void)segmentedControlValueChanged {
    _currentPage = (int)_segmentedControl.selectedSegmentIndex;
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * _currentPage;
    [_scrollView scrollRectToVisible:frame animated:YES];
}
@end
