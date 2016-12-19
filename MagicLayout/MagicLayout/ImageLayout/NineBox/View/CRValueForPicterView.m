//
//  CRValueForPicterView.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/21.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRValueForPicterView.h"

@protocol subValueViewDelegate <NSObject>

- (void)subValueViewDidBeginEditing:(CRSubValueView *)subValueView;

- (void)subValueViewDidChanging:(CRSubValueView *)subValueView string:(NSString *)string;

- (void)subValueViewValueChange:(CRSubValueView *)subValueView value:(CGFloat)value;

@end

@interface CRSubValueView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIButton * maxBtn;

@property (nonatomic, strong) UIButton * minBtn;

@property (nonatomic, strong) UISlider * slider;

@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, weak)id<subValueViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;

@end

@implementation CRSubValueView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color{
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self createSubValueView:color];
    }
    return self;
}

- (void)createSubValueView:(UIColor *)color{
    
    CGFloat ww = self.bounds.size.width;
    CGFloat hh = self.bounds.size.height;
    CGRect sliderRect = CGRectMake(hh+5, 0, ww-hh-5-hh-5-8-42, hh);
    CGRect textRect = CGRectMake(ww-42, 0, 42, 18);
    
    _minBtn = [self getSliderButton:CGRectMake(0, 0, hh, hh)];
    
    [_minBtn setTitle:@"-" forState:UIControlStateNormal];
    
    [_minBtn addTarget:self action:@selector(clickMinBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_minBtn];
    
    _slider = [[UISlider alloc]initWithFrame:sliderRect];
    
    _slider.maximumValue = 255;
    
    _slider.minimumValue = 0;
    
    _slider.minimumTrackTintColor = color;
    
    [_slider setThumbImage:[UIImage imageNamed:@"photosliderimg"] forState:UIControlStateNormal];
    
    [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_slider];
    
    _maxBtn = [self getSliderButton:CGRectMake(ww-50-hh, 0, hh, hh)];
    
    [_maxBtn setTitle:@"+" forState:UIControlStateNormal];
    
    [_maxBtn addTarget:self action:@selector(clickMaxBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_maxBtn];
    
    _textField = [[UITextField alloc] initWithFrame:textRect];
    
    _textField.font = [UIFont systemFontOfSize:12];
    
    _textField.textColor = [UIColor darkGrayColor];
    
    _textField.layer.borderWidth = 1;
    
    _textField.layer.borderColor = WHITECOLOR(168).CGColor;
    
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _textField.textAlignment = NSTextAlignmentCenter;
    
    _textField.text = @"0";
    
    _textField.delegate = self;
    
    [self addSubview:_textField];
}

- (UIButton *)getSliderButton:(CGRect)frame{
    
    CGFloat ww = frame.size.width;
    
    UIButton * sliderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    sliderBtn.frame = frame;
    
    sliderBtn.titleLabel.font = [UIFont systemFontOfSize:ww];
    
    [sliderBtn setTitleColor:WHITECOLOR(84) forState:UIControlStateNormal];
    
    return sliderBtn;
}

#pragma mark - slider method 
- (void)sliderChanged:(UISlider *)slider{
    
    _textField.text = [NSString stringWithFormat:@"%d",(int)slider.value];
    
    [self sendChangeValue];
}

- (void)clickMinBtn:(UIButton *)btn{

    [_slider setValue:_slider.value-1 animated:NO];
    
    [self sliderChanged:_slider];
}

- (void)clickMaxBtn:(UIButton *)btn{
   
    [_slider setValue:_slider.value+1 animated:NO];;
    
    [self sliderChanged:_slider];
}

#pragma mark - delegate and notification
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL result = YES;
    
    NSString * textStr = textField.text;
    
    NSMutableString * mutableString = [NSMutableString stringWithString:textStr];
    
    [mutableString replaceCharactersInRange:range withString:string];

    if (mutableString.integerValue >255) {
        
        mutableString = [NSMutableString stringWithString:@"255"];
        
        textField.text = mutableString;
        
        result = NO;
    }
    if ([self.delegate respondsToSelector:@selector(subValueViewDidChanging:string:)]) {
        
        [self.delegate subValueViewDidChanging:self string:mutableString];
    }
    return result;
}

- (void)sendChangeValue{
    
    if ([self.delegate respondsToSelector:@selector(subValueViewValueChange:value:)]) {
        
        [self.delegate subValueViewValueChange:self value:_textField.text.doubleValue];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([textField.text isEqualToString:@"0"]) {
        
        textField.text = @"";
    }
    if ([self.delegate respondsToSelector:@selector(subValueViewDidBeginEditing:)]) {
        
        [self.delegate subValueViewDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.text isEqualToString:@""]) {
        
        textField.text = @"0";
    }else if (textField.text.integerValue > 255) {
        
        textField.text = @"255";
    }
    _slider.value = textField.text.integerValue;
    
    [self sendChangeValue];
}

@end

@interface CRValueForPicterView ()<subValueViewDelegate>

@end

@implementation CRValueForPicterView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createView];
    }
    return self;
}

- (void)createView{
    
    CGFloat ww = self.bounds.size.width;
    CGFloat hh = self.bounds.size.height;
    CGRect colorRect = CGRectMake(8, (hh-60)*0.5, 50, 50);
    CGRect redSubRect           = CGRectMake(68, 10, ww-68-8, 20);
    CGRect greenSubRect         = CGRectMake(68, 36, ww-68-8, 20);
    CGRect blueSubRect          = CGRectMake(68, 62, ww-68-8, 20);

    self.backgroundColor = WHITECOLOR(233);
    
    _showColorView = [[UIView alloc]initWithFrame:colorRect];
    
    _showColorView.backgroundColor = WHITECOLOR(0);
    
    _showColorView.layer.borderColor = WHITECOLOR(200).CGColor;
    
    _showColorView.layer.borderWidth = 1.0f;
    
    [_showColorView addGestureRecognizer:[self getLongPressGesture]];
    
    [_showColorView addGestureRecognizer:[self getPanGestureRecognizer]];
    
    [self addSubview:_showColorView];

    _redSubVlaueView = [[CRSubValueView alloc]initWithFrame:redSubRect color:RGBCOLOR(200, 0, 0)];
    
    _redSubVlaueView.delegate = self;
    
    [self addSubview:_redSubVlaueView];
    
    _greenSubVlaueView = [[CRSubValueView alloc]initWithFrame:greenSubRect color:RGBCOLOR(0, 200, 0)];
    
    _greenSubVlaueView.delegate = self;
    
    [self addSubview:_greenSubVlaueView];
    
    _blueSubVlaueView = [[CRSubValueView alloc]initWithFrame:blueSubRect color:RGBCOLOR(0, 0, 200)];
    
    _blueSubVlaueView.delegate = self;
    
    [self addSubview:_blueSubVlaueView];
    
    //键盘监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard

- (UIView *)getEditView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 58)];
    
    view.backgroundColor = RGBCOLOR(210, 213, 219);
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, SCREENWIDTH-24-60, 42)];
    
    label.textColor = WHITECOLOR(0);
    
    label.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:label];
    
    UIButton * submitBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    submitBtn.frame = CGRectMake(SCREENWIDTH-68, 8, 60, 42);
    
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [submitBtn addTarget:self action:@selector(clickSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:submitBtn];
    
    return view;
}

- (UILabel *)editLabel{
    
    UILabel * label;
    
    for (UIView * subView in _editView.subviews) {
        
        if ([subView isKindOfClass:[UILabel class]]) {
            
            label = (UILabel *)subView;
        }
    }
    return label;
}

- (UILongPressGestureRecognizer *)getLongPressGesture{
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    
    longPress.minimumPressDuration = 1.0f;
    
    longPress.delegate = self;
    
    return longPress;
}


- (UIPanGestureRecognizer *)getPanGestureRecognizer{
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    
    pan.delegate = self;
    
    return pan;
}

#pragma mark - method

- (void)clickSubmitBtn:(UIButton *)btn{
    
    [_firstResponderText resignFirstResponder];
}

- (void)subValueViewDidBeginEditing:(CRSubValueView *)subValueView{
    
    _firstResponderText = subValueView.textField;
    
    if (!_editView) {
        
        _editView = [self getEditView];
        
    }
    [self editLabel].text = _firstResponderText.text;
}

- (void)subValueViewDidChanging:(CRSubValueView *)subValueView string:(NSString *)string{
    
    [self editLabel].text = string;
}

- (void)subValueViewValueChange:(CRSubValueView *)subValueView value:(CGFloat)value{
    
    CGFloat rr = _redSubVlaueView.textField.text.integerValue;
    CGFloat gg = _greenSubVlaueView.textField.text.integerValue;
    CGFloat bb = _blueSubVlaueView.textField.text.integerValue;
    
    _showColorView.backgroundColor = RGBCOLOR(rr, gg, bb);
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    if (!_showing) {
        return;
    }
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];

    [window addSubview:_editView];
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    typeof(_editView) __weak weakView = _editView;
    [UIView animateWithDuration:animationDuration animations:^{
        
        weakView.frame = CGRectMake(0, keyboardRect.origin.y-58, SCREENWIDTH, 58);
        
    }];
}
- (void)keyboardWillHide:(NSNotification *)notification {

    if (!_showing) {
        return;
    }
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    typeof(_editView) __weak weakView = _editView;
    [UIView animateWithDuration:animationDuration animations:^{
        
        weakView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 58);
        
    } completion:^(BOOL finished) {
        
        [weakView removeFromSuperview];
    }];
}

#pragma mark - longPress method

- (void)longPressGesture:(UILongPressGestureRecognizer *)longPress{
    
    //选中图片，实现一个代理
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        
    }else if (longPress.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"longpress end");
    }
}


#pragma mark - pan method

- (void)panGesture:(UIPanGestureRecognizer *)pan{
    
    if ([self.delegate respondsToSelector:@selector(CRValueForPicterViewColorShowView:panGestureRecognizer:)]) {
        
        [self.delegate CRValueForPicterViewColorShowView:_showColorView panGestureRecognizer:pan];
    }
}


@end
