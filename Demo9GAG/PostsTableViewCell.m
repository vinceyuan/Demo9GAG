//
//  PostsTableViewCell.m
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "PostsTableViewCell.h"
#import "Post.h"
#import "UIImageView+WebCache.h"

@implementation PostsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (NSString *) reuseIdentifier {
    return @"PostsTableViewCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithPosts:(NSArray *)posts heights:(NSArray *)heights index:(NSInteger)index {
    if (index >= [posts count])
        return;

    Post *post = [posts objectAtIndex:index];
    _labelCaption.text = post.caption;
    _labelPoints.text = [NSString stringWithFormat:@"%d points", post.voteCount];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:post.imageUrl] placeholderImage:nil];
}

@end
