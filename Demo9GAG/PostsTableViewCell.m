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
#import "ProgressImageView.h"

UILabel *helperLabel = nil;

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

+ (CGFloat)heightOfCaptionForPost:(Post *)post width:(CGFloat)width {
    if (!helperLabel) {
        helperLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        helperLabel.font = [UIFont boldSystemFontOfSize:17];
        helperLabel.numberOfLines = 0;
        helperLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    CGFloat captionWidth = width - LEFT_MARGIN - RIGHT_MARGIN;
    helperLabel.text = post.caption;
    CGSize captionSize = [helperLabel sizeThatFits:CGSizeMake(captionWidth, 1000)];
    CGFloat captionHeight = captionSize.height;
    return captionHeight;
}

+ (CGFloat)heightOfCellForPost:(Post *)post width:(CGFloat)width {

    CGFloat captionHeight = [PostsTableViewCell heightOfCaptionForPost:post width:width];
    // If image is not downloaded, use the default height.
    // If image is downloaded, calculate height according to the image height/width ratio.
    float imageHeight = DEFAULT_IMAGE_HEIGHT;
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:post.imageUrl]) {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[post.imageUrl absoluteString]];
        imageHeight = width * image.size.height / image.size.width;
    }
    float height = TOP_MARGIN + captionHeight + CAPTION_IMAGE_VERT_INTERVAL + imageHeight + IMAGE_POINTS_VERT_INTERVAL + POINTS_HEIGHT + BOTTOM_MARGIN;
    return height;
}


- (void)setupWithPosts:(NSArray *)posts index:(NSInteger)index width:(float)width {

    if (index >= [posts count])
        return;

    Post *post = [posts objectAtIndex:index];
    _labelCaption.text = post.caption;
    _labelPoints.text = [NSString stringWithFormat:@"%d points", post.voteCount];
    CGFloat captionHeight = [PostsTableViewCell heightOfCaptionForPost:post width:width];

    // When the image is downloadeded, we show the image directly.
    // When the image is not downloaded, we download it and then reload this cell.
    float imageHeight;
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:post.imageUrl]) {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[post.imageUrl absoluteString]];
        imageHeight = width * image.size.height / image.size.width;
        _imageView.image = image;

    } else {
        imageHeight = DEFAULT_IMAGE_HEIGHT;
        _imageView.image = nil;
        [_imageView setProgress:0 total:1];
        [[SDWebImageManager sharedManager] downloadImageWithURL:post.imageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_imageView setProgress:receivedSize total:expectedSize];
            });
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [_imageView removeProgressView];
            if (!error) {
                if (self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(postsTableViewCellDownloadedPostIndex:)]) {
                    [self.downloadDelegate postsTableViewCellDownloadedPostIndex:index];
                }
            }
        }];
    }
    _labelCaption.frame = CGRectMake(LEFT_MARGIN, TOP_MARGIN, width - LEFT_MARGIN - RIGHT_MARGIN, captionHeight);
    _imageView.frame = CGRectMake(0, _labelCaption.frame.origin.y + _labelCaption.frame.size.height + CAPTION_IMAGE_VERT_INTERVAL, width, imageHeight);
    _labelPoints.frame = CGRectMake(LEFT_MARGIN, _imageView.frame.origin.y + _imageView.frame.size.height + IMAGE_POINTS_VERT_INTERVAL, POINTS_WIDTH, POINTS_HEIGHT);
}

@end
