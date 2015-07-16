//
//  Downloader.m
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "Downloader.h"
#import "Post.h"
#import "AFNetworking.h"

@implementation Downloader

- (void)downloadWithCompletion:(void (^)(NSArray *posts, NSError *error))completion {
    NSString *string = self.baseUrl;
    if (!_next && [_next length] != 0) {
        string = [string stringByAppendingString:_next];
    }
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"Response: %@", responseObject);
        NSMutableArray *posts = [[NSMutableArray alloc] init];
        NSArray *array = [responseObject valueForKey:@"data"];
        for (id item in array) {
            Post *post = [[Post alloc] init];
            post.postId = [item valueForKey:@"id"];
            post.caption = [item valueForKey:@"caption"];
            post.imageUrl = [item valueForKeyPath:@"images.normal"];
            post.link = [item valueForKey:@"link"];
            post.voteCount = [(NSNumber *)[item valueForKeyPath:@"votes.count"] intValue];
            [posts addObject:post];
        }
        _next = [responseObject valueForKeyPath:@"paging.next"];
        if (completion) {
            completion(posts, nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (completion) {
            completion(nil, error);
        }
    }];

    // 5
    [operation start];
}

@end
