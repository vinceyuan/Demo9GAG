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

@end
