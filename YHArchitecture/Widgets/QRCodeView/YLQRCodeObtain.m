//
//  YLQRCodeObtain.m
//  Supplier
//
//  Created by Yangli on 2020/6/8.
//  Copyright © 2020 永辉. All rights reserved.
//

#import "YLQRCodeObtain.h"
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>
#import "YLQRCodePreview.h"

@interface YLQRCodeObtain ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, YLQRCodePreviewDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) YLQRCodePreview *previewView;

@property (nonatomic, copy) void(^lightObserver)(BOOL, BOOL);
@property (nonatomic, copy) void(^callback)(NSString *);
@property (nonatomic, assign) BOOL lightObserverHasCalled;
@property (nonatomic, assign) BOOL autoStop;


@end

@implementation YLQRCodeObtain

- (AVCaptureSession *)session
{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    return _session;
}

- (instancetype)initWithPreviewView:(YLQRCodePreview *)previewView completion:(nonnull void (^)(void))completion
{
    self = [super init];
    if (self) {
        
        if ([previewView isKindOfClass:[YLQRCodePreview class]]) {
            _previewView = (YLQRCodePreview *)previewView;
            _previewView.delegate = self;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        // 在全局队列开启新线程，异步初始化AVCaptureSession（比较耗时）
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 1、捕获设备输入流
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error) {
            NSLog(@"没有摄像头-%@", error.localizedDescription);
            return nil;
        }
        // 2、捕获元数据输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        //        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [output setMetadataObjectsDelegate:(id<AVCaptureMetadataOutputObjectsDelegate>)self queue:dispatch_get_main_queue()];
        
        if ([self.session canAddInput:input]) {
            [self.session addInput:input];
        }
//        [self.session addInput:input];
        if ([self.session canAddOutput:output]) {
            [self.session addOutput:output];
            [output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode]];
        }
        
//        if ([self.session canAddOutput:output]) {
//            [self.session addOutput:output];
//            if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode] &&
//                [output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code] &&
//                [output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
//                output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
//            }
//        }

        //            [device lockForConfiguration:nil];
                
//        if (device.isFocusPointOfInterestSupported && [device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
//            device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
//        }
        //            [device unlockForConfiguration];
                    
                    
        AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        previewLayer.frame = previewView.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [previewView.layer insertSublayer:previewLayer atIndex:0];
                    
        // 设置扫码区域
        CGRect rectFrame = self.previewView.rectFrame;
        if (!CGRectEqualToRect(rectFrame, CGRectZero)) {
            CGFloat y = rectFrame.origin.y / previewView.bounds.size.height;
            CGFloat x = (previewView.bounds.size.width - rectFrame.origin.x - rectFrame.size.width) / previewView.bounds.size.width;
            CGFloat h = rectFrame.size.height / previewView.bounds.size.height;
            CGFloat w = rectFrame.size.width / previewView.bounds.size.width;
            output.rectOfInterest = CGRectMake(y, x, h, w);
        }
        //                     可以在[session startRunning];之后用此语句设置扫码区域
        output.rectOfInterest = [previewLayer metadataOutputRectOfInterestForRect:rectFrame];
        
        
        // 缩放手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [previewView addGestureRecognizer:pinchGesture];
        
        // 停止previewView上转动的指示器
        [self.previewView stopIndicating];
        
        if (completion) {
            completion();
        }        
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Public functions

- (void)startScanningWithCallback:(void (^)(NSString * _Nonnull))callback
{
    [self startScanningWithCallback:callback autoStop:NO];
}

- (void)startScanningWithCallback:(void (^)(NSString * _Nonnull))callback autoStop:(BOOL)autoStop
{
    _callback = callback;
    _autoStop = autoStop;
    
    [self startScanning];
}

- (void)startScanning
{
    if (_session && !_session.isRunning) {
        [_session startRunning];
        [_previewView startScanning];
    }
    
    __weak typeof(self) weakSelf = self;
    [self observeLightStatus:^(BOOL dimmed, BOOL torchOn) {
        if (dimmed || torchOn) {
            [weakSelf.previewView stopScanning];
            [weakSelf.previewView showTorchSwitch];
        } else {
            [weakSelf.previewView startScanning];
            [weakSelf.previewView hideTorchSwitch];
        }
    }];
}

- (void)stopScanning
{
    if (_session && _session.isRunning) {
        [_session stopRunning];
        [_previewView stopScanning];
    }
    [YLQRCodeObtain switchTouch:NO];
    [YLQRCodeObtain resetZoomFactor];
}

- (void)presentPhotoLibraryWithRooter:(UIViewController *)rooter callback:(nonnull void (^)(NSString * _Nonnull))callback
{
    _callback = callback;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [rooter presentViewController:imagePicker animated:YES completion:nil];
}

- (void)handleCodeString:(NSString *)codeString
{
    if (_autoStop) {
        [self stopScanning];
    }
    if (_callback) {
        _callback(codeString);
    }
}


#pragma mark - Notification functions

- (void)applicationWillEnterForeground:(NSNotification *)notification
{
    [self startScanning];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    [self stopScanning];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    AVMetadataMachineReadableCodeObject *code = metadataObjects.firstObject;
    
    if (code.stringValue) {
        [self handleCodeString:code.stringValue];
    }
}


#pragma mark - QiCodePreviewViewDelegate

- (void)codeScanningView:(YLQRCodePreview *)scanningView didClickedTouchSwitch:(UIButton *)switchButton
{
    switchButton.selected = !switchButton.selected;
    
    [YLQRCodeObtain switchTouch:switchButton.selected];
    _lightObserverHasCalled = switchButton.selected;
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *pickedImage = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    CIImage *detectImage = [CIImage imageWithData:UIImagePNGRepresentation(pickedImage)];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    CIQRCodeFeature *feature = (CIQRCodeFeature *)[detector featuresInImage:detectImage options:nil].firstObject;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (feature.messageString) {
            [self handleCodeString:feature.messageString];
        }
    }];
}

#pragma mark - 打开/关闭手电筒

- (void)observeLightStatus:(void (^)(BOOL, BOOL))lightObserver
{
    _lightObserver = lightObserver;
    
    AVCaptureVideoDataOutput *lightOutput = [[AVCaptureVideoDataOutput alloc] init];
    [lightOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    if ([_session canAddOutput:lightOutput]) {
        [_session addOutput:lightOutput];
    }
}

+ (void)switchTouch:(BOOL)on
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureTorchMode torchMode = on? AVCaptureTorchModeOn: AVCaptureTorchModeOff;
    
    if (device.hasFlash && device.hasTorch && torchMode != device.torchMode) {
        [device lockForConfiguration:nil];
        [device setTorchMode:torchMode];
        [device unlockForConfiguration];
    }
}


#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CFDictionaryRef metadataDicRef = CMCopyDictionaryOfAttachments(NULL, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadataDic = (__bridge NSDictionary *)metadataDicRef;
    NSDictionary *exifDic = metadataDic[(__bridge NSString *)kCGImagePropertyExifDictionary];
    CFRelease(metadataDicRef);
    
    CGFloat brightness = [exifDic[(__bridge NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    BOOL torchOn = device.torchMode == AVCaptureTorchModeOn;
    BOOL dimmed = brightness < 1.0;
    static BOOL lastDimmed = NO;
    
    if (_lightObserver) {
        if (!_lightObserverHasCalled) {
            _lightObserver(dimmed, torchOn);
            _lightObserverHasCalled = YES;
            lastDimmed = dimmed;
        }
        else if (dimmed != lastDimmed) {
            _lightObserver(dimmed, torchOn);
            lastDimmed = dimmed;
        }
    }
}



#pragma mark - 缩放手势

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    CGFloat minZoomFactor = 1.0;
    CGFloat maxZoomFactor = device.activeFormat.videoMaxZoomFactor;
    
    if (@available(iOS 11.0, *)) {
        minZoomFactor = device.minAvailableVideoZoomFactor;
        maxZoomFactor = device.maxAvailableVideoZoomFactor;
    }
    
    static CGFloat lastZoomFactor = 1.0;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        lastZoomFactor = device.videoZoomFactor;
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat zoomFactor = lastZoomFactor * gesture.scale;
        zoomFactor = fmaxf(fminf(zoomFactor, maxZoomFactor), minZoomFactor);
        [device lockForConfiguration:nil];
        device.videoZoomFactor = zoomFactor;
        [device unlockForConfiguration];
    }
}


#pragma mark - Private functions

+ (void)resetZoomFactor
{
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    [device lockForConfiguration:nil];
//    device.videoZoomFactor = 1.0;
//    [device unlockForConfiguration];
}

@end
