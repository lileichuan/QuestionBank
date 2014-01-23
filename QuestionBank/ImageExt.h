#import <Foundation/Foundation.h>

@interface UIImage (UIImageExt)

+ (UIImage *)screenshotForScreenImage;
+ (UIImage *)screenshotImageForView:(UIView *)view;

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end