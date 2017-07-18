# musixise-ios-client
ios client project for musixise
# Musixise

> 本文主要对`musixise`做一次粗略的工程解释

### 一 .  app架构
#### 1. 本App采用MVVM架构 
- M --> MYBaseModel : JSONModel
- V --> MYBaseItemView : UIView
- VM --> MYBaseViewModel : NSObject

	页面大多用`tableView`（is kind of `MYBaseTableView`）形式实现 (`MYTableViewController`)
 		页面`tableview`的`delegate`建议抽出成类，继承 MYBaseTableViewDelegate(该类已实现`UITableViewDelegate`,`UITableViewDataSource`)
 		
#### 2. ViewController
ViewController大多继承`MYTableViewController`，该类使用到了`MReJfresh`用于支持上拉下拉刷新。
另外也支持很多其他的页面形式，如：
-  	 底部tab `MYTabBarViewController`
-  	 鱼眼页面 `MYBaseSortTableViewController`
-  	 grid页面 `MYCollectionViewController`
-   与js相关的页面继承 `MYWebViewController`

#### 3. Delegate

-  `MYBaseMergeTableViewDelegate` : 用于将不同的delegate进行合并的工具，使之实现不同的section调用不同的delegate
-  `MYBaseCollectionDelegate` : 用于grid页面
-  `MYBaseSortTableViewDelegate` : 用于鱼眼页面

#### 4. ViewModel
`ViewModel`大多继承`MYBaseViewModel`及`MYBaseListModel`,这两者分别用于详情页和列表页。
- `MYBaseMergeViewModel` ： 用于合并多个`ViewModel`
- `MYBaseSortListModel`：用于鱼眼
#### 5. app启动
1. web初始化
2. 页面初始化 （`MYAppDelegateUtils`）
3. 换肤初始化
4. 第三方初始化
5. 当用户发生变化时，重新显示login

#### 5. 页面
app的页面由根页面`MYRootTabBarViewController`及各个子页面组成

#### 10. 一些工具
1. 对空白页做了支持 具体参看 MYNoDataViewManager
2. 支持`scheme`跳转，形式为 `musixise://...`
 	跳转管理者为 `MYRouter`，需要在app启动时进行注册，（具体代码参看 `MYAppDelegateUtils`）

###二 pod
####  网络层 MYNetwork
 对AFNetworking做了一次封装
 - `MYAPIMethodConst`：用于存放请求网络的`method`
 - `MYBaseNetWorkUtil`：请求网络封装
 
 （*里面的类名名字没取好*）

####  播放引擎 MYAudio
 	支持mini进行播放

####  图片库 MYImageService
 	对SDWebImage做了一次封装

####  组件库 MYWidget
- 支持换肤

#### 分享库 MYShare

#### 三方库 MYThirdKit
- `MYThirdManager`: 外部只能调用此管理类，入口

#### 用户系统 MYUserSystem

#### 基础工具 MYUtils
- 日志使用CocoalumbersJask


设计目的：
`MYBaseItemView`及`Delegate`的设计都是为了能够更好的复用


   			  
