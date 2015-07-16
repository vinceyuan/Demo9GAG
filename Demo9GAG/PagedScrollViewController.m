//
//  PagedScrollViewController.m
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "PagedScrollViewController.h"
#import "ImagesTableViewController.h"

static NSUInteger kNumberOfPages = 3;

@interface PagedScrollViewController ()

@end

@implementation PagedScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
        ImagesTableViewController *controller = [[ImagesTableViewController alloc] initWithNibName:@"ImagesTableViewController" bundle:nil];
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

@end
