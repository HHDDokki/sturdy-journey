//
//  HYStepper.m
//  HYStepper
//
//  Created by zhuxuhong on 2017/7/16.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import "HYStepper.h"

NSString * lwzurlPrefix = @"http://172.16.4.58:8080";

@interface HYStepper()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *minusBtn;
@property(nonatomic,strong)UIButton *plusBtn;
@property(nonatomic,strong)UITextField *valueTF;

@end

@implementation HYStepper

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self initData];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initData];
        
        [self setupUI];
    }
    return self;
}

-(void)initData{
    _isValueEditable = true;
    _stepValue = 1;
    _minValue = 0;
    _maxValue = 10000;
    
    self.value = 0;
}

-(void)setupUI{
    self.translatesAutoresizingMaskIntoConstraints = false;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)]];
    [self addSubview: self.minusBtn];
    [self addSubview: self.plusBtn];
    [self addSubview: self.valueTF];
    
    [self setupLayout];
}

- (void)onTap {
    
}

-(void)setupLayout{
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.equalTo(self);
        make.right.equalTo(self.valueTF.mas_left);
    }];
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.equalTo(self);
        make.left.equalTo(self.valueTF.mas_right);
    }];
    [self.valueTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

#pragma mark - action
-(void)actionForButtonClicked: (UIButton*)sender{
    if ([sender isEqual:_minusBtn]) {
        [self changeCount:_value - _stepValue isAdd:NO];
    }else if([sender isEqual:_plusBtn]){
        [self changeCount:_value + _stepValue isAdd:YES];
    }
}

-(void)actionForTextFieldValueChanged: (UITextField*)sender{
    if ([sender isEqual:_valueTF]) {
        self.value = [sender.text doubleValue];
    }
    _valueChanged ? _valueChanged(self.value) : nil;
}

#pragma mark - setters
-(void)setValue:(double)value{
    if (value < _minValue) {
        value = _minValue;
    }
    else if (value > _maxValue){
        value = _maxValue;
    }
    
    if (self.isDetailSubviews) {
        if (value == 0) {
            _value = 1;
            _valueTF.text = [NSString stringWithFormat:@""];
        }else{
            _valueTF.text = [NSString stringWithFormat:@"%.0f",value];
        }
    }else{
        _valueTF.text = [NSString stringWithFormat:@"%.0f",value];
    }
   
    
    _minusBtn.enabled = value > _minValue;
    _plusBtn.enabled = value < _maxValue;
    _value = value;
    
}

-(void)setMaxValue:(double)maxValue{
    if (maxValue < _minValue) {
        maxValue = _minValue;
    }
    _maxValue = maxValue;
}

-(void)setMinValue:(double)minValue{
    if (minValue > _maxValue) {
        minValue = _maxValue;
    }
    _minValue = minValue;
}

-(void)setIsValueEditable:(BOOL)isValueEditable{
    _isValueEditable = isValueEditable;
    
    _valueTF.enabled = _isValueEditable;
}

#pragma mark - private
-(UIButton*)actionButtonWithTitle: (NSString*)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionForButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


#pragma mark - getters

-(UITextField *)valueTF{
    if (!_valueTF) {
        UITextField *tf = [UITextField new];
        tf.font = [UIFont systemFontOfSize:17];
        [tf addTarget:self action:@selector(actionForTextFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        tf.borderStyle = UITextBorderStyleNone;
        tf.textColor = UIColorFromHex(0xB5B5B5);
        tf.layer.borderColor = UIColorFromHex(0xB5B5B5).CGColor;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.textAlignment = NSTextAlignmentCenter;
        tf.enabled = self.isValueEditable;
        tf.delegate = self;
        tf.placeholder = @"1";
        tf.translatesAutoresizingMaskIntoConstraints = false;
        tf.text = [NSString stringWithFormat:@"%.0f",self.value];
        
        _valueTF = tf;
    }
    return _valueTF;
}

-(UIButton *)minusBtn{
    if (!_minusBtn) {
        UIButton *btn = [self actionButtonWithTitle:@""];
        btn.translatesAutoresizingMaskIntoConstraints = false;

        _minusBtn = btn;
    }
    return _minusBtn;
}

-(UIButton *)plusBtn{
    if (!_plusBtn) {
        UIButton *btn = [self actionButtonWithTitle:@""];
        btn.translatesAutoresizingMaskIntoConstraints = false;

        _plusBtn = btn;
    }
    return _plusBtn;
}

- (void)setStepBtnCorlor:(UIColor *)stepBtnCorlor{
    if (_stepBtnCorlor != stepBtnCorlor) {
        _stepBtnCorlor = stepBtnCorlor;
        self.plusBtn.backgroundColor = stepBtnCorlor;
        self.minusBtn.backgroundColor = stepBtnCorlor;
    }
}

- (void)setBtnTitleCorlor:(UIColor *)btnTitleCorlor{
    if (_btnTitleCorlor != btnTitleCorlor) {
        _btnTitleCorlor = btnTitleCorlor;
        self.plusBtn.tintColor = btnTitleCorlor;
        self.minusBtn.tintColor = btnTitleCorlor;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    if (_borderWidth != borderWidth) {
        _borderWidth = borderWidth;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = UIColorFromHex(0xA7A7A7).CGColor;
        self.valueTF.layer.borderWidth = borderWidth;
        if (borderWidth == 0) {
            self.layer.borderColor = [UIColor whiteColor].CGColor;
            self.valueTF.layer.borderColor = [UIColor whiteColor].CGColor;
        }
    }
}

- (void)setTextfieldTextCorlor:(UIColor *)textfieldTextCorlor{
    if (_textfieldTextCorlor != textfieldTextCorlor) {
        _textfieldTextCorlor = textfieldTextCorlor;
        self.valueTF.textColor = textfieldTextCorlor;
    }
}

- (void)setWidthMultiple:(float)widthMultiple{
    if (_widthMultiple != widthMultiple) {
        _widthMultiple = widthMultiple;
        [self.valueTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width).multipliedBy(widthMultiple);
            make.top.bottom.equalTo(self);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
}

- (void)setMiniBtnImage:(NSString *)miniBtnImage{
    if (_miniBtnImage != miniBtnImage) {
        _miniBtnImage = miniBtnImage;
        [self.minusBtn setImage:[UIImage imageNamed:miniBtnImage] forState:UIControlStateNormal];
    }
}

- (void)setMaxBtnImage:(NSString *)maxBtnImage{
    if (_maxBtnImage != maxBtnImage) {
        _maxBtnImage = maxBtnImage;
        [self.plusBtn setImage:[UIImage imageNamed:maxBtnImage] forState:UIControlStateNormal];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}


#pragma mark -- changeCoutn
- (void)changeCount:(double)goodscount isAdd:(BOOL)isadd{
    [kWindow makeToastActivity];
    NSDictionary * param = @{
                             @"cartId":[NSNumber numberWithInteger:self.carid],
                             @"goodsNum":[NSNumber numberWithDouble:goodscount]
                             };
    __weak typeof(self) weakSelf = self;
    __block BOOL canChange = NO;
    __block dispatch_semaphore_t sem = dispatch_semaphore_create(0); // gcd 信号量
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_updateGoodsNum) parameters:param success:^(id  _Nonnull responseObject) {
            [kWindow hideToastActivity];
            if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
                canChange = YES;
                dispatch_semaphore_signal(sem); // 信号
            }else{
                [kWindow makeToast:[responseObject objectForKey:@"msg"]];
                canChange = NO;
                dispatch_semaphore_signal(sem); // 信号
            }
        } failure:^(NSError * _Nonnull error) {
            dispatch_semaphore_signal(sem); // 信号
        }];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

        dispatch_async(dispatch_get_main_queue(), ^{
            if (canChange) {
                weakSelf.maxValue = 10000;
                if (isadd) {
                    weakSelf.value = self->_value + self->_stepValue;
                }else{
                    weakSelf.value = self->_value - self->_stepValue;
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:PostCenterName object:nil];
            }else{
                weakSelf.value = self->_value;
                weakSelf.maxValue = self->_value;
            }
            self->_valueChanged ? self->_valueChanged(self.value) : nil;
        });
        
    });
}

@end
