//
//  TopPostsTableViewCell.h
//  Demo9GAG
//
//  Created by Vince Yuan on 18/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XibTableViewCell.h"

@interface TopPostsTableViewCell : XibTableViewCell {

    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_labelCaption;
}

- (void)setupWithPosts:(NSArray *)posts index:(NSInteger)index;

@end
