//
//  BarProgressView.h
//  ATV Series
//
//  Created by Avikant Saini on 12/19/15.
//  Copyright © 2015 avikantz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

IB_DESIGNABLE

@interface BarProgressView : NSView

@property (nonatomic) IBInspectable CGFloat progress;
@property (nonatomic, strong) IBInspectable NSColor *fillColor;

- (void)animateProgress:(CGFloat)progress;

@end
