//
//  PostsTableViewController.h
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Downloader;

@interface PostsTableViewController : UITableViewController {
    NSMutableArray *_posts;
    float _width;
}

@property (strong, nonatomic) Downloader *downloader;

@end
