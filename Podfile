# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'Aweme' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
 use_frameworks!
 # 布局
    pod 'SnapKit'
    # 颜色
    pod 'DynamicColor'
    # 颜色渐变
    pod 'Hue'
    # banner
    pod 'FSPagerView'
    # 上下拉刷新
#    pod 'ESPullToRefresh'
    # js 交互
    pod 'WKWebViewJavascriptBridge'
    # webViewController
    # todo
    # page vc
    pod 'PagingKit'
    # segment
    pod 'Segmentio'
    # rac
    pod 'RxAtomic'
    pod 'RxSwift'
    pod 'RxCocoa'
    # web image
    pod 'SDWebImage'
    pod 'Kingfisher'
    # hud
#    pod 'PKHUD'
    # keyboardmanager
    pod 'IQKeyboardManagerSwift'
    # charts
#    pod 'Charts'
    # animations
    #pod 'Spring'
    # router
    pod 'URLNavigator'
    # waiting cell
    pod 'SkeletonView'
    #
#    pod 'CircleProgressView'
    #
    pod 'SHFullscreenPopGestureSwift'

    pod 'RAMAnimatedTabBarController'
    pod 'Segmentio'
    
#    pod 'EVGPUImage2', '~> 0.2.0'

    #github sshiqiao
    pod 'Alamofire'
    pod 'HandyJSON'
    pod 'Starscream'
    
    # 第三方
    pod 'Bugly'
    pod 'JPush'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
            end
        end
    end
end
