//
//  PostsTableViewCell.h
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XibTableViewCell.h"

@interface PostsTableViewCell : XibTableViewCell {

    __weak IBOutlet UILabel *_labelCaption;
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_labelPoints;
}

- (void)setupWithPosts:(NSArray *)posts heights:(NSArray *)heights index:(NSInteger)index;

@end
