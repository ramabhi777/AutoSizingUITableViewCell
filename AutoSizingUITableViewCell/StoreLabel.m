//
//  StoreLabel.m
//  AutoSizingUITableViewCell
//
//  Created by Abhishek Shukla on 01/10/15.
//  Copyright (c) 2015 InnovationM. All rights reserved.
//

#import "StoreLabel.h"

@implementation StoreLabel

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    // If this is a multiline label, need to make sure
    // preferredMaxLayoutWidth always matches the frame width
    // (i.e. orientation change can mess this up)
    
    if (self.numberOfLines == 0 && bounds.size.width != self.preferredMaxLayoutWidth) {
        self.preferredMaxLayoutWidth = self.bounds.size.width;
        [self setNeedsUpdateConstraints];
    }
}

@end
