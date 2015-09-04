//
//  XibTableViewCell.m
//  Demo9GAG
//
//  Created by Vince Yuan on 17/7/15.
//  Copyright (c) 2015 Vince Yuan. All rights reserved.
//

#import "XibTableViewCell.h"

@implementation XibTableViewCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

+ (XibTableViewCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    XibTableViewCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[XibTableViewCell class]]) {
            xibBasedCell = (XibTableViewCell *)nibItem;
            break; // we have a winner
        }
    }
    
    return xibBasedCell;
}

+ (CGFloat)heightOfCell {
    return 44.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
