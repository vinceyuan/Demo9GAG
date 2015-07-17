//
//  XibTableViewCell.h
//  Demo9GAG
//
//  Created by Vince Yuan on 17/7/15.
//  Copyright (c) 2015 Vince Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XibTableViewCell : UITableViewCell

+ (XibTableViewCell *)cellFromNibNamed:(NSString *)nibName;
+ (CGFloat)heightOfCell;

@end
