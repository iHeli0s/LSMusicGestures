#import <UIKit/UIKit.h>
UISwipeGestureRecognizer *swipeGestureRight;
UISwipeGestureRecognizer *swipeGestureLeft;
UITapGestureRecognizer *tapGesture;
%hook SBAwayView
-(void)finishedAnimatingIn {
%orig;
if(swipeGestureLeft)
[swipeGestureLeft release];
if(swipeGestureRight)
[swipeGestureRight release];
if(tapGesture)
[tapGesture release];
tapGesture = nil;
swipeGestureRight = nil;
swipeGestureLeft = nil;
swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
tapGesture.numberOfTapsRequired = 2;
swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
	//[swipeGesture setDelegate:self];
	//[swipeGesture canBePreventedByGestureRecognizer:MSHookIvar<UIGestureRecognizer *>(self,"_gestureRecognizer")];
	[self addGestureRecognizer:swipeGestureRight];
		[self addGestureRecognizer:swipeGestureLeft];
		[self addGestureRecognizer:tapGesture];

}


%new(v@:@)
-(void)swiped:(UISwipeGestureRecognizer *)sender {
UIView *mediaView = [[%c(SBAwayMediaControlsView) alloc]init];
if(!CGRectContainsPoint([MSHookIvar<UIView *>(self,"_lockBar") frame], [sender locationInView:self]) && !CGRectContainsPoint([MSHookIvar<UIView *>(self,"_dateView") frame], [sender locationInView:self]) ) {
if(sender.direction == UISwipeGestureRecognizerDirectionLeft) {
[mediaView _changeTrackButtonUp:MSHookIvar<UIButton *>(mediaView,"_prevButton")];
}
else {
[mediaView _changeTrackButtonUp:MSHookIvar<UIButton *>(mediaView,"_nextButton")];
}
[mediaView release];

}
}
%new(v@:@)
-(void)tapped:(UITapGestureRecognizer *)sender {
if(!CGRectContainsPoint([MSHookIvar<UIView *>(self,"_lockBar") frame], [sender locationInView:self]) && !CGRectContainsPoint([MSHookIvar<UIView *>(self,"_dateView") frame], [sender locationInView:self]) ) {
UIView *mediaView = [[%c(SBAwayMediaControlsView) alloc]init];

[mediaView _playPauseButtonAction:MSHookIvar<UIButton *>(mediaView,"_playPauseButton")];
[mediaView release];
}

}


-(void)lockBarStartedTracking:(id)tracking {

swipeGestureRight.enabled = NO;
swipeGestureLeft.enabled = NO;

%orig;
}
-(void)lockBarStoppedTracking:(id)tracking {

swipeGestureRight.enabled = YES;
swipeGestureLeft.enabled = YES;

%orig;

}
%end

%hook SBAwayMediaControlsView
- (void)_volumeChange:(id)arg1 {
swipeGestureRight.enabled = NO;
swipeGestureLeft.enabled = NO;
%orig;
swipeGestureRight.enabled = YES;
swipeGestureLeft.enabled = YES;
}

%end