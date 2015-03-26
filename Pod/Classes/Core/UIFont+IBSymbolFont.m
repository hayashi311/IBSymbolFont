//
//  Created by CocoaPods on TODAYS_DATE.
//  Copyright (c) 2014 PROJECT_OWNER. All rights reserved.
//

#import "UIFont+IBSymbolFont.h"
@import CoreText;

@interface IBBundleKey : NSObject
@end
@implementation IBBundleKey
@end

NSString *const kIBSymbolFontFamilyName = @"icons";

@implementation UIFont (IBSymbolFont)

+ (instancetype)ib_symbolFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:kIBSymbolFontFamilyName size:size];
    if (!font) {
        NSBundle* bundle = [NSBundle bundleForClass:[IBBundleKey class]];
        NSString *fontPath = [bundle pathForResource:kAASymbolFontFamilyName ofType:@"ttf"];
        NSData *inData = [NSData dataWithContentsOfFile:fontPath];
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)inData);
        CGFontRef cgFont = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(cgFont, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(cgFont);
        CFRelease(provider);
        font = [UIFont fontWithName:kAASymbolFontFamilyName size:size];
    }
    return font;
}

@end
