//
//  TopPostsTableViewCell.m
//  Demo9GAG
//
//  Created by Vince Yuan on 18/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "TopPostsTableViewCell.h"
#import "Post.h"
#import <QuartzCore/QuartzCore.h>

@implementation TopPostsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    _imageView.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithPosts:(NSArray *)posts index:(NSInteger)index {
    Post *post = [posts objectAtIndex:index];
    _labelCaption.text = post.caption;
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"top%02ld.jpg", (long)index]];
}
@end
