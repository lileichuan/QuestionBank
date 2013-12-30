#import "TreemapView.h"
#import "TreemapViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TreemapViewCell


@synthesize textLabel;
@synthesize index;
@synthesize delegate;

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];

       textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 4, 20)];
        textLabel.font = [UIFont boldSystemFontOfSize:20];
        textLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        textLabel.textAlignment = UITextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        textLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    textLabel.frame = CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    if (delegate && [delegate respondsToSelector:@selector(treemapViewCell:tapped:)]) {
        [delegate treemapViewCell:self tapped:index];
    }
}

- (void)dealloc {
    if (textLabel) {
        [textLabel removeFromSuperview];
        [textLabel release];
        textLabel = nil;
    }
  
    [delegate release];

    [super dealloc];
}

@end
