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
#import "SDWebImageManager.h"
#import "SDImageCache.h"

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

- (void)setupWithPosts:(NSArray *)posts index:(NSInteger)index width:(float)width {

    if (index >= [posts count])
        return;

    Post *post = [posts objectAtIndex:index];
    _labelCaption.text = post.caption;
    _labelPoints.text = [NSString stringWithFormat:@"%d points", post.voteCount];

    // When the image is downloadeded, we show the image directly.
    // When the image is not downloaded, we download it and then reload this cell.
    float imageHeight;
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:post.imageUrl]) {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[post.imageUrl absoluteString]];
        //[_imageView sd_setImageWithURL:post.imageUrl];
        imageHeight = width * image.size.height / image.size.width;
        _imageView.image = image;
    } else {
        imageHeight = DEFAULT_IMAGE_HEIGHT;
        _imageView.image = nil;
        [[SDWebImageManager sharedManager] downloadImageWithURL:post.imageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!error) {
                if (self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(postsTableViewCellDownloadedPostIndex:)]) {
                    [self.downloadDelegate postsTableViewCellDownloadedPostIndex:index];
                }
            }
        }];
    }
    _labelCaption.frame = CGRectMake(8, 7, width - 8 * 2, 21);
    _imageView.frame = CGRectMake(0, 30, width, imageHeight);
    _labelPoints.frame = CGRectMake(8, imageHeight + 30 + 3, 105, 20);
}

@end
