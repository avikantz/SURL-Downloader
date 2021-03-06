//
//  ViewController.m
//  DBM Downloader
//
//  Created by Avikant Saini on 7/19/15.
//  Copyright (c) 2015 avikantz. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController {
	CGFloat incProgress;
	NSString *saveTitle;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Do any additional setup after loading the view.
	
	_loadingSpinner.hidden = YES;
	[self.barProgressView animateProgress:0.0];
	_progressIndicator.hidden = YES;
	_statusLabel.hidden = YES;
	_saveButton.hidden = NO;
	
	if ([[NSUserDefaults standardUserDefaults] valueForKey:@"PATH"]) {
		_pathField.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"PATH"];
		_urlFormatField.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"URL"];
		_extensionField.stringValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"EXT"];
		_toField.integerValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"TO"];
		_fromField.integerValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"FROM"];
		_urlSeqCountField.integerValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"URLSEQ"];
		_sequenceStarterField.integerValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"SEQ"];
	}
	
}

- (void)setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];
	
	// Update the view, if already loaded.
}

- (IBAction)saveAction:(id)sender {
	
	_progressIndicator.doubleValue = 0;
	_progressIndicator.maxValue = 100;
	_progressIndicator.minValue = 0;
	
	_saveButton.hidden = YES;
	_statusLabel.hidden = NO;
	_statusLabel.stringValue = @"Loading...";
	
//	if (![_urlFormatField.stringValue hasSuffix:@"/"])
//		_urlFormatField.stringValue = [NSString stringWithFormat:@"%@/", _urlFormatField.stringValue];
	
	[[NSUserDefaults standardUserDefaults] setObject:_urlFormatField.stringValue forKey:@"URL"];
	[[NSUserDefaults standardUserDefaults] setObject:_pathField.stringValue forKey:@"PATH"];
	[[NSUserDefaults standardUserDefaults] setObject:_extensionField.stringValue forKey:@"EXT"];
	[[NSUserDefaults standardUserDefaults] setInteger:_toField.integerValue forKey:@"TO"];
	[[NSUserDefaults standardUserDefaults] setInteger:_fromField.integerValue forKey:@"FROM"];
	[[NSUserDefaults standardUserDefaults] setInteger:_urlSeqCountField.integerValue forKey:@"URLSEQ"];
	[[NSUserDefaults standardUserDefaults] setInteger:_sequenceStarterField.integerValue forKey:@"SEQ"];
	
	_loadingSpinner.hidden = NO;
	[_loadingSpinner startAnimation:nil];
	_progressIndicator.hidden = NO;
	
	__block NSInteger k = _sequenceStarterField.integerValue;
	incProgress = 100/(_toField.integerValue - _fromField.integerValue);
	
	NSString *numberFormat = [NSString stringWithFormat:@"%%0.%lili", [_urlSeqCountField integerValue]];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		for (NSInteger i = [_fromField integerValue]; i <= [_toField integerValue]; ++i) {
			
			// Linear saving of things
			NSData *thing = nil;
			
			if ([_urlFormatField stringValue]) {
				
				NSString *urlString = [NSString stringWithFormat:@"%@%@", _urlFormatField.stringValue, [[NSString stringWithFormat:numberFormat, i] stringByAppendingString:_extensionField.stringValue]];
				
				saveTitle = [NSString stringWithFormat:@"Saving: '%@'", [urlString lastPathComponent]];
				
				// Download things.
				thing = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
				
				NSString *extension = _extensionField.stringValue;
				
				if (![[NSFileManager defaultManager] fileExistsAtPath:[self imagesPathForFileName:[NSString stringWithFormat:@"%.2li%@", k, extension]]])
					[thing writeToFile:[self imagesPathForFileName:[NSString stringWithFormat:@"%.2li%@", k, extension]] atomically:YES];
				else {
					NSString *filePath = [self imagesPathForFileName:[NSString stringWithFormat:@"%.2li%@", k, extension]];
					NSInteger counter = 2;
					while ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
						filePath = [self imagesPathForFileName:[NSString stringWithFormat:@"%.2li_%li%@", k, counter++, extension]];
					}
					[thing writeToFile:filePath atomically:YES];
				}
				
				dispatch_async(dispatch_get_main_queue(), ^{
					[_progressIndicator incrementBy:incProgress];
					[self.barProgressView animateProgress:_progressIndicator.doubleValue/100];
					_statusLabel.stringValue = saveTitle;
				});
				
			}
			
			k += 1;
			
		}
		
		saveTitle = @"Done...";
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[_progressIndicator incrementBy:incProgress];
			[self.barProgressView animateProgress:0.0];
			_statusLabel.stringValue = saveTitle;
			_statusLabel.hidden = YES;
			_saveButton.hidden = NO;
			_sequenceStarterField.integerValue += (_toField.integerValue - _fromField.integerValue + 1);
			_loadingSpinner.hidden = YES;
			_progressIndicator.hidden = YES;
		});
		
	});
	
}

- (NSString *)imagesPathForFileName:(NSString *)name {
	NSFileManager *manager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [NSString stringWithFormat:@"%@", [paths lastObject]];
	[manager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@/", [paths lastObject], _pathField.stringValue] withIntermediateDirectories:YES attributes:nil error:nil];
	return [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@", _pathField.stringValue, name]];
}

-(void)prepareForSegue:(nonnull NSStoryboardSegue *)segue sender:(nullable id)sender {
	if ([segue.identifier isEqualToString:@"SelfSegue"]) {
		ViewController *vc = [segue destinationController];
		vc.title = @"Sequencial URL Downloader";
	}
}

@end
