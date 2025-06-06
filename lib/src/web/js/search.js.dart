@JS("AMap")
library amap_flutter;

import 'dart:js_interop';
import 'package:web/web.dart' show HTMLDivElement, HTMLElement;
import 'js.dart';

/// 根据输入关键字提示匹配信息，可将Poi类型和城市作为输入提示的限制条件。用户可以通过自定义回调函数取回并显
extension type AutoComplete._(JSObject _) implements JSObject {
  /// 构造函数
  external AutoComplete(AutoCompleteOptions opts);

  /// 设置提示Poi类型，多个类型用“|”分隔，POI相关类型请在网站“相关下载”处下载，目前只支持Poi类型编码如“050000” 默认值：所有类别
  external void setType(JSString type);

  /// 设置城市
  external void setCity(JSString city);

  /// 设置是否强制限制城市
  external void setCityLimit(JSBoolean citylimit);

  /// 根据输入关键字提示匹配信息，支持中文、拼音
  external void search(JSString keyword, AutoCompleteSearchCallback callback);
}

extension type AutoCompleteOptions._(JSObject _) implements JSObject {
  /// 构造函数
  AutoCompleteOptions() : this._(JSObject());

  /// 输入提示时限定POI类型，多个类型用“|”分隔，目前只支持Poi类型编码如“050000” 默认值：所有类别
  external JSString type;

  /// 输入提示时限定城市。可选值：城市名（中文或中文全拼）、citycode、adcode；默认值：“全国”
  external JSString city;

  /// 返回的数据类型。可选值：all-返回所有数据类型、poi-返回POI数据类型、bus-返回公交站点数据类型、busline-返回公交线路数据类型目前暂时不支持多种类型
  external JSString datatype;

  /// 是否强制限制在设置的城市内搜索,默认值为：false，true：强制限制设定城市，false：不强制限制设定城市
  external JSBoolean citylimit;

  /// 可选参数，用来指定一个input输入框，设定之后，在input输入文字将自动生成下拉选择列表。支持传入输入框DOM对象的id值，或直接传入输入框的DOM对象
  external HTMLDivElement input;

  /// 可选参数，指定一个现有的div的id或者元素，作为展示提示结果的容器，当指定了input的时候有效，缺省的时候将自动创建一个显示结果面板
  external HTMLDivElement? output;

  /// 默认为true，表示是否在input位于页面较下方的时候自动将输入面板显示在input上方以避免被遮挡
  external JSBoolean outPutDirAuto;

  /// 页面滚动时关闭搜索结果列表，默认 true
  external JSBoolean closeResultOnScroll;

  /// 设置检索语言类型，默认中文 'zh_cn'
  external JSString lang;
}

/// 提示匹配信息回调函数扩展类型
extension type AutoCompleteSearchCallback(JSFunction _) implements JSFunction {
  external void call(JSString status, AutoCompleteSearchResult result);
}

extension type AutoCompleteSearchResult._(JSObject _) implements JSObject {
  /// 构造函数
  AutoCompleteSearchResult() : this._(JSObject());

  /// 查询状态说明
  external JSString info;

  /// 输入提示条数
  external JSNumber count;

  /// 输入提示列表
  external JSArray<Tip> tips;
}

extension type Tip._(JSObject _) implements JSObject {
  /// 构造函数
  Tip() : this._(JSObject());

  /// 名称
  external JSString name;

  /// 所属区域
  external JSString district;

  /// 区域编码
  external JSString adcode;
}

/// 地点搜索服务插件，提供某一特定地区的位置查询服务
extension type PlaceSearch._(JSObject _) implements JSObject {
  /// 构造函数
  external PlaceSearch();

  /// 根据输入关键字提示匹配信息，支持中文、拼音
  external void search(JSString keyword, SearchCallback callback);

  /// 根据范围和关键词进行范围查询
  external void searchInBounds(
    JSString keyword,
    Bounds bounds,
    SearchCallback callback,
  );

  /// 根据中心点经纬度、半径以及关键字进行周边查询 radius取值范围：0-50000
  external void searchNearBy(JSString keyword, LngLat center, num radius);

  /// 根据PGUID 查询POI 详细信息
  external void getDetails(@JS("PGUID") JSString pguid);

  /// 设置查询类别，多个类别用“|”分割
  external void setType(JSString type);

  /// 设置显示查询结果页码
  external void setPageIndex(num pageIndex);

  /// 设置每页显示查询结果数量
  external void setPageSize(num pageSize);

  /// 设置查询城市, 支持cityname（中文或中文全拼）、citycode、adcode
  external void setCity(JSString city);

  /// 设置是否强制限制城市
  external void setCityLimit(JSBoolean citylimit);

  /// 唤起高德地图客户端marker页 JSObject 参数：{ id: "B000A7BD6C", POIID name:JSString, 必要参数 location:LngLat|position属性 必须参数 } 例如：{ id: "B000A7BD6C", location: LngLat, name: "清华大学", address: "地址" }
  external void poiOnAMAP(JSAny p, JSObject opts);

  /// 唤起高德地图客户端POI详情页 JSObject 参数：{ id: "B000A7BD6C", POIID name:JSString, 必要参数 location:LngLat|position属性 必须参数 }
  external void detailOnAMAP(JSAny p, JSObject opts);
}

/// 搜索结果回调函数扩展类型
extension type SearchCallback(JSFunction _) implements JSFunction {
  external void call(JSString status, PlaceSearchResult result);
}

extension type PlaceSearchResult._(JSObject _) implements JSObject {
  /// 构造函数
  PlaceSearchResult() : this._(JSObject());

  /// 成功状态说明
  external JSString info;

  /// 发生事件且查无此关键字时，返回建议关键字列表，可根据建议关键字查询
  external JSArray<JSString> keywordList;

  /// 发生事件且查无此关键字且 city 为“全国”时，返回城市建议列表，该列表中每个城市包含一个或多个相关Poi点信息
  external JSArray<CityInfo> cityList;

  /// 发生事件时返回兴趣点列表
  external PoiList poiList;
}

extension type PoiList._(JSObject _) implements JSObject {
  /// 构造函数
  PoiList() : this._(JSObject());

  /// 页码
  external JSNumber pageIndex;

  /// 单页结果数
  external JSNumber pageSize;

  /// 查询结果总数
  external JSNumber count;

  /// Poi列表
  external JSArray<POI> pois;
}

extension type POI._(JSObject _) implements JSObject {
  /// 构造函数
  POI() : this._(JSObject());

  /// 兴趣点id
  external JSString id;

  /// 名称
  external JSString name;

  /// 兴趣点类型
  external JSString type;

  /// 兴趣点经纬度
  external LngLat location;

  /// 地址
  external JSString address;

  /// 离中心点距离，仅周边查询返回
  external JSNumber distance;

  /// 电话
  external JSString tel;

  /// 网址
  external JSString website;

  /// poi所在省份编码
  external JSString pcode;

  /// poi所在城市编码
  external JSString citycode;

  /// poi所在区域编码
  external JSString adcode;

  /// 邮编
  external JSString postcode;

  /// poi所在省份
  external JSString pname;

  /// poi所在城市名称
  external JSString cityname;

  /// poi所在行政区名称
  external JSString adname;

  /// 电子邮箱
  external JSString email;

  /// 入口经纬度，POI点有出入口信息时返回，否则返回空字符串
  @JS("entr_location")
  external LngLat entrenceLocation;

  /// 出口经纬度，POI点有出入口信息时返回，否则返回空字符串
  @JS("exit_location")
  external LngLat exitLocation;
}

/// 云数据检索服务类
extension type CloudDataSearch._(JSObject _) implements JSObject {
  external CloudDataSearch(JSString tableid, CloudDataSearchOptions opts);

  /// 设置云数据检索属性
  external void setOptions(CloudDataSearchOptions opts);

  /// 清除搜索结果
  external void clear();

  /// 周边检索，根据指定的中心点和半径检索位置数据
  external void searchNearBy(
    LngLat center,
    num radius,
    CloudDataSearchCallback callback,
  );

  /// 根据数据id检索位置数据，id检索时不需要设置CloudDataSearchOptions
  external void searchById(JSString id, CloudDataSearchCallback callback);

  /// 根据行政区划（包括全国/省/市/区县）名称，检索行政区划内位置数据
  external void searchByDistrict(
    JSString district,
    CloudDataSearchCallback callback,
  );

  /// 多边形检索，根据给定的多边形节点坐标数组，检索位置数据。如果数组只有两个坐标元素，则认为多边形为矩形，这两个点为矩形的左下、右上点。多边形坐标数组的起、终点必须保证多边形闭合（起、终点坐标相同）
  external void searchInPolygon(
    JSArray<LngLat> path,
    CloudDataSearchCallback callback,
  );
}

extension type CloudDataSearchOptions._(JSObject _) implements JSObject {
  /// 构造函数
  CloudDataSearchOptions() : this._(JSObject());

  /// AMap.Map对象, 展现结果的地图实例。当指定此参数后，搜索结果的标注、线路等均会自动添加到此地图上。可选值
  external AMap map;

  /// 云检索关键字，仅支持对建立了文本索引的字段进行模糊检索（请在 云数据管理平台 中管理文本索引）
  external JSString keywords;

  /// 云检索的筛选条件,仅支持对建立了排序筛选索引的字段进行筛选（请在云数据管理平台中管理排序筛选索引）；支持多个筛选条件，支持对文本字段的精确匹配和对数值字段的区间筛选。筛选条件之间使用“+”代表“与”关系,如：filter:"_name:酒店+star: [3,5] "(等同于SOL语句的：WHERE_name="酒店" AND star BETWEEN 3 AND 5)
  external JSString filter;

  /// 返回数据的排序规则。1.支持系统预设排序规则：_distance：坐标与中心点距离升序排序（仅对周边检索有效；）_weight：权重降序排序。默认值：1)当设置了keywords时，默认按"_weight"权重排序；2)当未设置keywords时，默认按"_distance"距离排序。2.支持对建立了排序筛选索引的整数或小数字段进行排序（请在云数据管理平台中管理排序筛选索引）。升降序分别为"ASC"、"DESC",若仅填字段不填升降序则默认按升序排列，如：orderBy:"age:ASC"
  external JSString orderBy;

  /// 单页显示结果数，取值范围 [0-100] ,超过取值范围取默认值，默认：20
  external JSNumber pageSize;

  /// 当前页码，取值>=1,默认1
  external JSNumber pageIndex;

  /// 结果列表的HTML容器id或容器元素，提供此参数后，结果列表将在此容器中进行展示。可选值
  external HTMLElement panel;

  /// 用于控制在搜索结束后，是否自动调整地图视野使绘制的Marker点都处于视口的可见范围
  external JSBoolean autoFitView;
}

/// 搜索结果回调函数的扩展类型
extension type CloudDataSearchCallback(JSFunction _) implements JSFunction {
  external void call(JSString status, JSObject result);
}

extension type CloudDataSearchResult._(JSObject _) implements JSObject {
  /// 构造函数
  CloudDataSearchResult() : this._(JSObject());

  /// 成功状态文字描述
  external JSString info;

  /// 查询结果总数
  external JSNumber count;

  /// 云数据数组，当根据数据id检索时，数据仅包含一个CloudData
  external JSArray<JSObject> datas;

  /// 数据id，id为数据唯一标识
  @JS("_id")
  external JSString id;

  /// 名称
  @JS("_name")
  external JSString name;

  /// 坐标
  @JS("_location")
  external LngLat location;

  /// 地址
  @JS("_address")
  external JSString address;

  /// 数据更新时间
  @JS("_updatetime")
  external JSString updatetime;

  /// 距离中心点距离(仅周边查询时返回)
  @JS("_distance")
  external JSNumber distance;

  /// 用户自定义字段1
  @JS("custom_field1")
  external JSAny customField1;

  /// 图片信息
  @JS("_image")
  external JSArray<Image> image;
}

extension type Image._(JSObject _) implements JSObject {
  /// 构造函数
  Image() : this._(JSObject());

  /// 图片的id标识
  @JS("_id")
  external JSString id;

  /// 经过压缩处理的图片地址,尺寸为400*400，若期望获取体积较小的图片文件，建议使用此地址
  @JS("_preurl")
  external JSString preurl;

  /// 最大限制获取1024*1024，若您的原始图片小于该尺寸，将返回原图
  @JS("_url")
  external JSString url;
}
