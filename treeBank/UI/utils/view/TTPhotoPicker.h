//
//  TTPhotoPicker.h
//  Pods
//
//  Created by kebi on 15/12/9.
//
//

#import <Foundation/Foundation.h>

/**图片选择及拍照
 *
 */

@interface TTPhotoPicker : NSObject
+(TTPhotoPicker*)showCameraToAllowsEditing:(BOOL)allowsEditing
                              singleSelect:(BOOL)isSingleSelect
                                     block:(void(^)(NSArray *image))block;





@end
