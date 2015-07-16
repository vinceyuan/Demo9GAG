//
//  Downloader.h
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Downloader : NSObject {
    NSString *_next;

}

@property (strong, nonatomic) NSString *baseUrl;

- (void)downloadWithCompletion:(void (^)(NSArray *posts, NSError *error))completion;

@end
