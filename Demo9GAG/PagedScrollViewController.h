//
//  PagedScrollViewController.h
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagedScrollViewController : UIViewController {
    NSMutableArray *_viewControllers;
    int _currentPage;
    UISegmentedControl *_segmentedControl;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
