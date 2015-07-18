//
//  Post.m
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "Post.h"

@implementation Post

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ \"%@\" %@ %@ %d", self.postId, self.caption, self.imageUrl, self.link, self.voteCount];
}

- (void)parseJSON:(id)dict {
    self.postId = [dict valueForKey:@"id"];
    self.caption = [dict valueForKey:@"caption"];
    self.imageUrl = [NSURL URLWithString:[dict valueForKeyPath:@"images.large"]];
    self.link = [dict valueForKey:@"link"];
    self.voteCount = [(NSNumber *)[dict valueForKeyPath:@"votes.count"] intValue];

}

+ (instancetype)postWithCaption:(NSString *)caption {
    Post *post = [[Post alloc] init];
    post.caption = caption;
    return post;
}

@end
