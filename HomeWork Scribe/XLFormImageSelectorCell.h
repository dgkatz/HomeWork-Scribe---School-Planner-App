//
//  XLFormImageSelectorCell.h
//  
//
//  Created by Daniel Katz on 5/13/15.
//
//

#import "XLFormBaseCell.h"

NSString *const kFormImageSelectorCellDefaultImage;
NSString *const kFormImageSelectorCellImageRequest;

@interface XLFormImageSelectorCell : XLFormBaseCell

@property (nonatomic, readonly) UIImageView * imageView;
@property (nonatomic, readonly) UILabel * textLabel;

@end