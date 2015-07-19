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

#define LEFT_MARGIN 8
#define RIGHT_MARGIN 8
#define TOP_MARGIN 9
#define CAPTION_IMAGE_VERT_INTERVAL 3
#define DEFAULT_IMAGE_HEIGHT 240
#define IMAGE_POINTS_VERT_INTERVAL 4
#define POINTS_WIDTH 105
#define POINTS_HEIGHT 20
#define BOTTOM_MARGIN 5

@class Post;
@protocol PostsTableViewCellDownloadDelegate;

@interface PostsTableViewCell : XibTableViewCell {

    __weak IBOutlet UILabel *_labelCaption;
    __weak IBOutlet ProgressImageView *_imageView;
    __weak IBOutlet UILabel *_labelPoints;
}

+ (CGFloat)heightOfCellForPost:(Post *)post width:(CGFloat)width;

- (void)setupWithPosts:(NSArray *)posts index:(NSInteger)index width:(float)width;

@property (weak, nonatomic) id<PostsTableViewCellDownloadDelegate> downloadDelegate;

@end

@protocol PostsTableViewCellDownloadDelegate <NSObject>

- (void)postsTableViewCellDownloadedPostIndex:(NSInteger)index;

@end