//
//  SREButton.m
//  Originally built for Soiree
//
//  Created by Shady Gabal on 9/13/15.
//  Copyright (c) 2015 Shady Gabal. All rights reserved.
//

#import "SREButton.h"

@interface SREButton ()

@end

@implementation SREButton{
    BOOL _setColors, _setFrames;
    BOOL _animatingToEnlarged, _animatingToOriginal, _highlightAnimating;
    CGRect _originalFrame, _enlargedFrame;
    CGFloat _originalFontSize;
    CGAffineTransform _originalTransform, _enlargedTransform;
    UIEdgeInsets _originalInsets;
}


#define k_BUTTON_ANIMATED_SIZE_MULTIPLIER 1.0275
#define k_Button_Corner_Radius 4.

#pragma mark - Create

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        _originalFrame = frame;
    }
    return self;
}

+(CGRect) createEnlargedFrame:(CGRect)frame{
    return [SREButton createEnlargedFrame:frame multiplier:k_BUTTON_ANIMATED_SIZE_MULTIPLIER];
}

+(CGRect) createEnlargedFrame:(CGRect) frame multiplier:(double) multiplier{
    
    double newWidth = frame.size.width * multiplier ;
    double newHeight = frame.size.height * multiplier;
    CGRect enlargedFrame = CGRectMake(frame.origin.x - (newWidth - frame.size.width)/2., frame.origin.y - (newHeight - frame.size.height)/2., newWidth, newHeight);
    
    return enlargedFrame;
}

-(void) modifyWithText:(NSString *) text fontSize:(double) fontSize font:(NSString *) font textColor:(UIColor *) textColor rectangular:(BOOL) rectangular{
    if (!font)
        font = @"HelveticaNeue-Light";
    if (!textColor)
        textColor = [UIColor whiteColor];
    
    self.disabledColor = [UIColor colorWithWhite:.8f alpha:.5f];
    self.enabledColor = textColor;
    self.userInteractionEnabled = YES;
    self.enabled = YES;
    
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:textColor forState:UIControlStateNormal];
    [self setTitleColor:self.disabledColor forState:UIControlStateDisabled];
    
    if (rectangular){
        [self makeRectangularButton];
    }
    
    
    self.titleLabel.font = [UIFont fontWithName:font size:fontSize];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.shadowColor = [UIColor blackColor];
    [self sizeToFit];
    
    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0., 1.);
    //    button.layer.masksToBounds = NO;
    self.layer.shadowRadius = 0.;


}

-(void) makeRectangularButton{
    [self addInsets];
    
}


-(void) addInsets{
    CGFloat fontSize = self.titleLabel.font.pointSize;
    double ratio = fontSize / 16.;
    double inset = 10 * ratio;
    
    [self addInsets:UIEdgeInsetsMake(inset, inset, inset, inset)];
}

-(void) addInsets:(UIEdgeInsets) insets{
    self.contentEdgeInsets = insets;
    
//    UIColor * color = self.currentTitleColor;
//    self.layer.borderWidth = 2.f;
//    self.layer.borderColor = color.CGColor;
    [self roundCorners];
    //    }
}

-(void) roundCorners{
    self.layer.cornerRadius = k_Button_Corner_Radius;
}

+(instancetype) buttonWithText:(NSString *) text fontSize:(double) fontSize font:(NSString *) font textColor:(UIColor *) textColor rectangular:(BOOL) rectangular{
    
    SREButton * button = [[SREButton alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    [button modifyWithText:text fontSize:fontSize font:font textColor:textColor rectangular:rectangular];
    return button;

}

#pragma mark - Activity Indicators


-(void) setEnabled:(BOOL)enabled{
    if (enabled && !self.enabled){
        self.layer.borderColor = self.enabledColor.CGColor;
    }
    else if (!enabled && self.enabled){
        self.layer.borderColor = self.disabledColor.CGColor;
        [self setTitleColor:self.disabledColor forState:UIControlStateDisabled];
    }
    [super setEnabled:enabled];

}



-(void) showActivityIndicatorView{
    if (!self.activityIndicator){
        UIActivityIndicatorViewStyle indicatorStyle = UIActivityIndicatorViewStyleWhite;

        CGFloat white, alpha;
        [self.backgroundColor getWhite:&white alpha:&alpha];
        if (self.activityIndicatorStyle){
            indicatorStyle = self.activityIndicatorStyle;
        }
        else if (white >= .7 && alpha > 0.){
            indicatorStyle = UIActivityIndicatorViewStyleGray;
        }
        
        
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:indicatorStyle];
        self.activityIndicator.center = CGPointMake(self.frame.size.width/2., self.frame.size.height/2.);
//        self.activityIndicator.center = self.center;
    }
    
    if (!self.activityIndicator.isAnimating){
        self.titleLabel.alpha = 0.;
        [self addSubview:self.activityIndicator];
        [self.activityIndicator startAnimating];
    }
}

-(void) hideActivityIndicatorView{
    if (self.activityIndicator){
        [self.activityIndicator removeFromSuperview];
        self.titleLabel.alpha = 1.;
        [self.activityIndicator stopAnimating];
    }
}

-(BOOL)isAnimating{
    return (self.activityIndicator && self.activityIndicator.isAnimating);
}

#pragma mark - Highlighted

-(void) unHighlight{
    self.highlighted = NO;
}

+(UIColor *) colorAfterRatio:(CGFloat) ratio color:(UIColor *) color{
    CGFloat red, blue, green, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return [UIColor colorWithRed:red * ratio green:green * ratio blue:blue * ratio alpha:alpha];
}

+(UIColor *) colorAfterRatio:(CGFloat) ratio color:(UIColor *) color alpha:(CGFloat)alpha{
    CGFloat red, blue, green, a;
    [color getRed:&red green:&green blue:&blue alpha:&a];
    return [UIColor colorWithRed:red * ratio green:green * ratio blue:blue * ratio alpha:alpha];
}

-(void) setHighlighted:(BOOL)highlighted{
    if (self.normalHighlight){
        return [super setHighlighted:highlighted];
    }
    
    //set highlight colors
    if (!self.dontHighlightColor){
        if (!self.backgroundColor){
            self.backgroundColor = [UIColor clearColor];
            if (!self.highlightedBackgroundColor)
                self.highlightedBackgroundColor = [UIColor colorWithWhite:.3f alpha:.05f];
        }
        else if (!self.highlightedBackgroundColor){
            CGFloat alpha;
            [self.backgroundColor getWhite:nil alpha:&alpha];
//            alpha = (alpha == 0.f ? 1.f : alpha);
            self.highlightedBackgroundColor = [SREButton colorAfterRatio:.8f color:self.backgroundColor alpha:alpha];
        }
        
        if (!self.originalBackgroundColor)
            self.originalBackgroundColor = self.backgroundColor;
    }

    double multiplier = self.highlightSizeMultiplier ?: k_BUTTON_ANIMATED_SIZE_MULTIPLIER;
    
    //if we have colors or we dont need them
    if ((self.originalBackgroundColor && self.highlightedBackgroundColor) || self.dontHighlightColor){
        
        
        if (highlighted){
            self.unhighlightTimer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(unHighlight) userInfo:nil repeats:NO];
            
            if (!_setFrames){
                _originalFrame = self.frame;
                _enlargedFrame = [SREButton createEnlargedFrame:self.frame multiplier:multiplier];
                _originalFontSize = self.titleLabel.font.pointSize;
                _originalTransform = self.titleLabel.transform;

                _enlargedTransform = CGAffineTransformScale(self.titleLabel.transform, multiplier, multiplier);
                _setFrames = YES;
                _originalInsets = self.contentEdgeInsets;
            }
            
            
            if (!self.dontEnlarge){
                self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                [UIView beginAnimations:nil context:nil];
                UIFont * font = self.titleLabel.font;
                self.titleLabel.font = [font fontWithSize:_originalFontSize * multiplier];
                self.titleLabel.shadowOffset = CGSizeMake(.5, .5);
                [UIView commitAnimations];
            }

            [UIView transitionWithView:self
                              duration:.1f
                               options:UIViewAnimationOptionCurveEaseIn
                            animations:^{
                                if (!self.dontHighlightColor)
                                    self.backgroundColor = self.highlightedBackgroundColor;
//                                self.layer.shadowOpacity = .25;
                                if (!_animatingToEnlarged && !self.dontEnlarge){
                                    NSLog(@"animating to enlarged...");
                                    self.frame = _enlargedFrame;
                                    
                                    _animatingToEnlarged = YES;
                                    _animatingToOriginal = NO;
                                }                                
                            }
                            completion:nil];
            
            _highlightAnimating = YES;

        }
        else{
            if (self.unhighlightTimer) [self.unhighlightTimer invalidate];
            [UIView beginAnimations:nil context:nil];
            UIFont * font = self.titleLabel.font;
            self.titleLabel.font = [font fontWithSize:_originalFontSize];
            self.titleLabel.shadowOffset = CGSizeMake(0, 0);
            [UIView commitAnimations];

            [UIView transitionWithView:self
                              duration:.10f
                               options:UIViewAnimationOptionCurveEaseIn
                            animations:^{
                                if (!self.dontHighlightColor)
                                    self.backgroundColor = self.originalBackgroundColor;
//                                self.layer.shadowOpacity = 0.;
                               
                                if (!_animatingToOriginal && !self.dontEnlarge){
                                    _animatingToOriginal = YES;
                                    _animatingToEnlarged = NO;
                                    NSLog(@"animating to original...");
                                    self.frame = _originalFrame;
                                    UIFont * font = self.titleLabel.font;
                                    self.titleLabel.font = [font fontWithSize:_originalFontSize];

//                                    self.titleLabel.transform = _originalTransform;
                                }
                               
                            }
                            completion:^(BOOL finished){
                                if (finished)
                                    self.contentEdgeInsets = _originalInsets;
                                    _highlightAnimating = NO;
                            }];
        }
    }
    
}

-(void) makeLayerSameColor{
    self.layer.borderColor = self.backgroundColor.CGColor;
}

#pragma mark - Misc

-(void) addBorders{
    [self addBordersWithColor:self.currentTitleColor];
}

-(void) addBordersWithColor:(UIColor *) color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 2.f;
    self.layer.cornerRadius = 5.;
}


- (CGSize) intrinsicContentSize {
    CGSize s = [super intrinsicContentSize];
    
    return CGSizeMake(s.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
                      s.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom);
    
}

@end
