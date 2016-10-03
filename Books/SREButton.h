//
//  SREButton.h
//  Originally built for Soiree
//
//  Created by Shady Gabal on 9/13/15.
//  Copyright (c) 2015 Shady Gabal. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Button subclassed to add features like easier initializing, growth and highlight animations on tap, activity indicators when the button is doing something, and more
 */
@interface SREButton : UIButton

/** @name Header Properties */

@property (nonatomic, strong) UIColor * disabledColor;
@property (nonatomic, strong) UIColor * enabledColor;

@property (nonatomic, strong) UIColor * originalBackgroundColor;
@property (nonatomic, strong) UIColor * highlightedBackgroundColor;
@property (nonatomic, assign) BOOL dontHighlightColor;
@property (nonatomic, assign) BOOL dontEnlarge;
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, assign) BOOL normalHighlight;
@property (nonatomic, assign) double highlightSizeMultiplier;
@property (nonatomic, strong) NSTimer * unhighlightTimer;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorStyle;

/** @name Header Methods */

-(void) showActivityIndicatorView;
-(void) hideActivityIndicatorView;
-(void) roundCorners;

@end
