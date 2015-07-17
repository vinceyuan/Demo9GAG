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
    if (_isDownloading)
        return;

    _isDownloading = YES;
    NSString *string = self.baseUrl;
    if (_next && [_next length] != 0) {
        string = [string stringByAppendingString:_next];
    }
    NSLog(@"Loading %@", string);
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        //NSLog(@"Response: %@", responseObject);
        NSMutableArray *posts = [[NSMutableArray alloc] init];
        NSArray *array = [responseObject valueForKey:@"data"];
        for (id item in array) {
            Post *post = [[Post alloc] init];
            post.postId = [item valueForKey:@"id"];
            post.caption = [item valueForKey:@"caption"];
            post.imageUrl = [NSURL URLWithString:[item valueForKeyPath:@"images.normal"]];
            post.link = [item valueForKey:@"link"];
            post.voteCount = [(NSNumber *)[item valueForKeyPath:@"votes.count"] intValue];
            [posts addObject:post];
        }
        _next = [responseObject valueForKeyPath:@"paging.next"];
        if (completion) {
            completion(posts, nil);
        }
        _isDownloading = NO;
        NSLog(@"Down");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (completion) {
            completion(nil, error);
        }
        _isDownloading = NO;
    }];

    [operation start];
}

@end
