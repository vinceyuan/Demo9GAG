//
//  ProgressImageView.m
//  Demo9GAG
//
//  Created by Vince Yuan on 18/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "ProgressImageView.h"

#define TAG_PROGRESS_VIEW 74632

@implementation ProgressImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIProgressView *)progressView {
    UIProgressView *progressView = (UIProgressView *)[self viewWithTag:TAG_PROGRESS_VIEW];

    if (!progressView) {
        CGRect bounds = self.bounds;
        progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.frame = CGRectMake(0, 0, bounds.size.width, 3);
        progressView.progressTintColor = [UIColor blueColor];
        progressView.tag = TAG_PROGRESS_VIEW;
        [self addSubview:progressView];
    }
    return progressView;
}

- (void)removeProgressView {
    UIProgressView *progressView = (UIProgressView *)[self viewWithTag:TAG_PROGRESS_VIEW];

    if (progressView) {
        [progressView removeFromSuperview];
        progressView = nil;
    }
}

- (void)setProgress:(NSInteger)receivedSize total:(NSInteger)expectedSize {
    UIProgressView *progressView = [self progressView];
    progressView.hidden = NO;
    if (receivedSize >= 0 && expectedSize > 0) {
        float progress = 1.0 * receivedSize / expectedSize;
        //NSLog(@"Progress: %0.1f", progress);
        progressView.progress = progress;
    } else {
        progressView.progress = 0;
    }
}

- (void)setImage:(UIImage * __nullable)image {
    if (image) {
        [self removeProgressView];
    }
    [super setImage:image];
}

@end
