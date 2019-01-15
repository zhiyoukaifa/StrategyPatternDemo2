//
//  InputValidator.h
//  StrategyPatternDemo
//
//  Created by 张三 on 2019/1/5.
//  Copyright © 2019 e家机械. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


static NSString * const InputValidationErrorDomain = @"InputValidationErrorDomain";



/**
 zs20190105 抽象基类 验证输入框的内容是否符合规则 这里不把接口声明为协议，而是声明为抽象基类。抽象基类更适合解决这种问题，因为它更容易重构各种具体策略子类的某些共同行为。  策略模式中扮演的角色：抽象策略
 */
@interface InputValidator : NSObject

@property (nonatomic, strong) NSString *strErrorMessage;    /**<zs20190115 验证失败时 提示的信息 */

@property (nonatomic, assign) NSUInteger lengthLimit;       /**<zs20190115 长度限制*/




/**
 zs20190115 在编辑的过程进行限制 没有错误信息返回

 @param textField 输入框
 */
- (void)limitInputContentOnEditing:(UITextField*)textField;


/**
 zs20190105 验证输入内容

 @param input 文本框
 @param error 错误信息
 @return YES 验证通过
 */
- (BOOL)validateInput:(UITextField*)input error:(NSError **)error;





//-----------zs20190115 以下方法 子类选择性调用--------------

/**
 zs20190115 验证emoji 表情

 @param textField 输入框
 */
- (void)validateEmojiLimit:(UITextField*)textField;



/**
 zs20190115 删除空格

 @param textField 输入框
 */
- (void)deleteWhiteSpace:(UITextField*)textField;



/**
 zs20190115 验证长度

 @param textField 输入框
 */
- (void)validateLength:(UITextField*)textField;



@end

NS_ASSUME_NONNULL_END
