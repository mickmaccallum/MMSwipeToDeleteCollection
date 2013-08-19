//
//  SwipeableCell.m
//  MMSwipeToDeleteCollection
//
//  Created by Photo on 8/19/13.
//  Copyright (c) 2013 MacCDevTeam LLC. All rights reserved.
//

#import "SwipeableCell.h"

@implementation SwipeableCell



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {


        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetected:)];
        [swipeGesture setDirection:UISwipeGestureRecognizerDirectionUp];

        NSArray* recognizers = [(UICollectionView *)self.superview gestureRecognizers];

        for (UIGestureRecognizer* aRecognizer in recognizers) {
            if ([aRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
                [aRecognizer requireGestureRecognizerToFail:swipeGesture];
            }
        }

        [self addGestureRecognizer:swipeGesture];

    }
    return self;
}

- (void)swipeDetected:(UISwipeGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [self setTransform:CGAffineTransformMakeTranslation(0.0f, -(self.frame.origin.y + self.frame.size.height))];
    } completion:^(BOOL finished) {
        [self setAlpha:0.0f];
        NSIndexPath *indexPath = [(UICollectionView *)self.superview indexPathForCell:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteSwipedCellNotification" object:indexPath];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
