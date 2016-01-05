//
//  UnderlinedTextField.m
//  SURL Downloader
//
//  Created by Avikant Saini on 1/5/16.
//  Copyright © 2016 avikantz. All rights reserved.
//

#import "UnderlinedTextField.h"

#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height

#define ORIGIN self.bounds.origin

@implementation UnderlinedTextField

- (void)drawRect:(NSRect)dirtyRect {
	
	[super drawRect:dirtyRect];
	
	if (!self.lineColor)
		self.lineColor = self.textColor;
	if (!self.lineWidth)
		self.lineWidth = 1.f;
	if (!self.offset)
		self.offset = 4.f;
	
	NSBezierPath *bezierPath = [NSBezierPath bezierPath];
	[self.lineColor setStroke];
	[bezierPath moveToPoint:NSPointFromCGPoint(CGPointMake(self.offset, HEIGHT - self.lineWidth))];
	[bezierPath lineToPoint:NSPointFromCGPoint(CGPointMake(WIDTH - self.offset * 2, HEIGHT - self.lineWidth))];
	[bezierPath stroke];
	
}

@end
