//
//  ViewController.h
//  SURL Downloader
//
//  Created by Avikant Saini on 7/19/15.
//  Copyright (c) 2015 avikantz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *fromField;
@property (weak) IBOutlet NSTextField *toField;

@property (weak) IBOutlet NSTextField *sequenceStarterField;

@property (weak) IBOutlet NSTextField *urlFormatField;
@property (weak) IBOutlet NSTextField *urlSeqCountField;
@property (weak) IBOutlet NSTextField *pathField;
@property (weak) IBOutlet NSTextField *extensionField;

@property (weak) IBOutlet NSProgressIndicator *progressIndicator;

- (IBAction)saveAction:(id)sender;
@property (weak) IBOutlet NSButton *saveButton;

@end

