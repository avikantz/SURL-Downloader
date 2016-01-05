//
//  BarProgressView.m
//  ATV Series
//
//  Created by Avikant Saini on 12/19/15.
//  Copyright © 2015 avikantz. All rights reserved.
//

#import "BarProgressView.h"

#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height
#define ORIGIN self.bounds.origin

@implementation BarProgressView

- (void)drawRect:(NSRect)dirtyRect {
	
    [super drawRect:dirtyRect];
    
    // Drawing code here.
	
	if (!self.progress)
		self.progress = 0.0;
	if (!self.fillColor)
		self.fillColor = [NSColor colorWithRed:204/255.f green:1.f blue:153/255.f alpha:1.f];
	
	NSRect rect = NSMakeRect(ORIGIN.x, ORIGIN.y, WIDTH * self.progress, HEIGHT);
	NSBezierPath *bezierPath = [NSBezierPath bezierPathWithRect:rect];
	[self.fillColor setFill];
	[bezierPath fill];
	
}

-(void)animateProgress:(CGFloat)progress {
	self.progress = progress;
	[self setNeedsDisplay:YES];
	[self setNeedsLayout:YES];
}

@end
