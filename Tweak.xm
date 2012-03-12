#import <UIKit/UIKit.h>

//tip for you: do a cleaner code next time =P

%hook SBAwayController
- (void)activate
{
	SBAwayView *view = MSHookIvar<SBAwayView *>(self, "_awayView");

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPause)];
	tap.numberOfTapsRequired = 2;
	[tap release];

	UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previous)];
    	[right setDirection:(UISwipeGestureRecognizerDirectionRight)];
    	[view addGestureRecognizer:right];
    	[right release];

	UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next)];
    	[left setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    	[view addGestureRecognizer:left];
    	[left release];
}
%new(v@:)
- (void)playPause
{
	[[objc_getClass("SBMediaController") sharedInstance] togglePlayPause];
}
- (void)next
{
	[[objc_getClass("SBMediaController") sharedInstance] changeTrack:1];
}
- (void)previous
{
	[[objc_getClass("SBMediaController") sharedInstance] changeTrack:-1];
}
%end