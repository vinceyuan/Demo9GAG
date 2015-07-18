//
//  ProgressImageView.h
//  Demo9GAG
//
//  Created by Vince Yuan on 18/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressImageView : UIImageView {
}

- (void)setProgress:(NSInteger)receivedSize total:(NSInteger)expectedSize;
- (void)removeProgressView;

@end
