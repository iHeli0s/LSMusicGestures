#import <UIKit/UIKit.h>

//tip for you: do a cleaner code next time =P

%hook SBAwayController
- (void)activate
{
	SBAwayView *view = MSHookIvar<SBAwayView *>(self, "_awayView");

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPause)];
	tap.numberOfTapsRequired = 2;
	[tap release];

	UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next)];
    	[right setDirection:(UISwipeGestureRecognizerDirectionRight)];
    	[view addGestureRecognizer:right];
    	[right release];

	UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previous)];
    	[left setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    	[view addGestureRecognizer:left];
    	[left release];
	
	%orig;
}
%new(v@:)
- (void)playPause
{
	[[%c(SBMediaController) sharedInstance] togglePlayPause];
}
- (void)next
{
	[[%c(SBMediaController) sharedInstance] changeTrack:1];
}
- (void)previous
{
	[[%c(SBMediaController) sharedInstance] changeTrack:-1];
}
%end

%hook SBAwayLockBar

- (void)knobDragged:(float)dragged
{
	right.enabled = NO;
	%orig;
}
- (void)upInKnob
{
	right.enabled = YES;
	%orig;
}
%end
