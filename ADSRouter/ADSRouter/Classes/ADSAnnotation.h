//
//  ADSAnnotation.h
//  annotation-demo
//
//  Created by Andy on 2017/9/25.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADSURL.h"

#define STRINGLIFY(str) #str

#define ADS_SECTION_NAME ADSRouter

#ifdef DEBUG

#define GetAt \
//class Test;

#define __ADS_CLASS_NAME_CHECK(className) \
void check##className() { \
[className new]; \
}

#define __ADS_PROPERTY_NAME_CHECK(className, propertyName) \
void check##className##propertyName() {\
[className new].propertyName; \
}

#else

#define __ADS_CLASS_NAME_CHECK(className)
#define __ADS_PROPERTY_NAME_CHECK(className, propertyName)

#endif


#define __ADS_DATA(sectName) __attribute((used, section("__DATA,"#sectName" ")))

#define ADS_REQUEST_MAPPING(className, url) \
__ADS_CLASS_NAME_CHECK(className); \
char * k##className __ADS_DATA(ADS_SECTION_NAME) = "{ \"url\": \""url"\", \"className\": \""#className"\"}";


#define ADS_PARAMETER_MAPPING(className, propertyName, paramName) \
__ADS_PROPERTY_NAME_CHECK(className, propertyName);\
-(NSDictionary<NSString*, NSString*>*) ads_propertymapping_##propertyName  { \
return @{@"paramName":@paramName, @"propertyName":@#propertyName};\
}


#define ADS_PARAMETER_MAPPING_SIMPLIFY(className, propertyName) \
ADS_PARAMETER_MAPPING(className, propertyName, STRINGLIFY(propertyName)); \

#define ADS_STORYBOARD_IN_BUNDLE(storyBoardName, storyBoardId, bundleName) \
- (NSString*)ads_bundleName { \
return @bundleName;\
} \
- (NSString*)ads_storyBoardName { \
return @storyBoardName;\
} \
- (NSString*)ads_storyBoardId { \
return @storyBoardId;\
}

#define ADS_STORYBOARD(storyBoardName, storyBoardId) \
ADS_STORYBOARD_IN_BUNDLE(storyBoardName, storyBoardId, "")

#define ADS_HIDE_BOTTOM_BAR \
- (BOOL)ads_hideBottomBar { \
return YES; \
}


#define ADS_HIDE_NAV \


#define ADS_PREPARE_SELECTOR() \


#define ADS_BEFORE_JUMP(beforeJumpBlock) \
- (void(^)(ADSURL *url, BOOL * abort))ads_beforeJumpBlock { \
    return beforeJumpBlock; \
}

#define ADS_SHOWSTYLE_PUSH_WITH_ANIMATION \
- (BOOL)ads_showstyle_push { \
return YES; \
}

#define ADS_SHOWSTYLE_PUSH_WITHOUT_ANIMATION \
- (BOOL)ads_showstyle_push { \
return NO; \
}

#define ADS_SHOWSTYLE_PRESENT \
- (void)ads_showstyle_present {}

#define ADS_SUPPORT_FLY \
- (void)ads_supportFly {}

@interface ADSAnnotation : NSObject

@end
