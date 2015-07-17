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

- (void)setupWithPosts:(NSArray *)posts index:(NSInteger)index width:(float)width tableView:(UITableView *)tableView {

//    _labelCaption.translatesAutoresizingMaskIntoConstraints = NO;
//    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
//    _labelPoints.translatesAutoresizingMaskIntoConstraints = NO;
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//    [_labelCaption layoutIfNeeded];
//    [_imageView layoutIfNeeded];
//    [_labelPoints layoutIfNeeded];
//    [self.contentView layoutIfNeeded];

    if (index >= [posts count])
        return;

    Post *post = [posts objectAtIndex:index];
    _labelCaption.text = post.caption;
    _labelPoints.text = [NSString stringWithFormat:@"%d points", post.voteCount];

    float imageHeight;
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:post.imageUrl]) {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[post.imageUrl absoluteString]];
        //[_imageView sd_setImageWithURL:post.imageUrl];
        imageHeight = width * image.size.height / image.size.width;
        _imageView.image = image;
    } else {
        imageHeight = 175;
        [_imageView sd_setImageWithURL:post.imageUrl placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                //[tableView beginUpdates];
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem: index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                //[tableView endUpdates];
            }
        }];
    }
    _labelCaption.frame = CGRectMake(8, 7, width - 8 * 2, 21);
    _imageView.frame = CGRectMake(0, 30, width, imageHeight);
    _labelPoints.frame = CGRectMake(8, imageHeight + 30 + 3, 105, 20);
}

@end
