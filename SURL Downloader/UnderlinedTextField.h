//
//  UnderlinedTextField.h
//  SURL Downloader
//
//  Created by Avikant Saini on 1/5/16.
//  Copyright © 2016 avikantz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

IB_DESIGNABLE

@interface UnderlinedTextField : NSTextField

@property (strong, nonatomic) IBInspectable NSColor *lineColor;
@property (nonatomic) IBInspectable CGFloat lineWidth;
@property (nonatomic) IBInspectable CGFloat offset;

@end
