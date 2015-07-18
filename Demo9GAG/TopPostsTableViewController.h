//
//  TopPostsTableViewController.h
//  Demo9GAG
//
//  Created by Vince Yuan on 18/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TopPostsTableViewCellWidth 168

typedef enum {
    TopSectionTypePosts = 0,
    TopSectionTypeLoadMore,
} TopSectionType;


@interface TopPostsTableViewController : UITableViewController

@end
