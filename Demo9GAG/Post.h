//
//  Post.h
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (strong, nonatomic) NSString *postId;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSString *link;
@property (assign, nonatomic) int voteCount;

- (void)parseJSON:(id)dict;
@end
