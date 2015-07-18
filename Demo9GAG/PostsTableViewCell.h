//
//  PostsTableViewCell.h
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XibTableViewCell.h"
#import "ProgressImageView.h"

#define DEFAULT_IMAGE_HEIGHT 240

@protocol PostsTableViewCellDownloadDelegate;

@interface PostsTableViewCell : XibTableViewCell {

    __weak IBOutlet UILabel *_labelCaption;
    __weak IBOutlet ProgressImageView *_imageView;
    __weak IBOutlet UILabel *_labelPoints;
}

- (void)setupWithPosts:(NSArray *)posts index:(NSInteger)index width:(float)width;

@property (weak, nonatomic) id<PostsTableViewCellDownloadDelegate> downloadDelegate;

@end

@protocol PostsTableViewCellDownloadDelegate <NSObject>

- (void)postsTableViewCellDownloadedPostIndex:(NSInteger)index;

@end