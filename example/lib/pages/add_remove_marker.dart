import 'package:amap_flutter/amap_flutter.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

/// 添加、移除标记点页面
class AddRemoveMarkerPage extends StatefulWidget {
  /// 添加、移除标记点页面构造函数
  const AddRemoveMarkerPage({super.key});

  /// 添加、移除标记点页面标题
  static const title = '动态添加、移除标记';

  @override
  State<AddRemoveMarkerPage> createState() => _AddRemoveMarkerPageState();
}

class _AddRemoveMarkerPageState extends State<AddRemoveMarkerPage> {
  late AMapController controller;
  final markers = <String, Marker>{};
  int _markerIdCounter = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.snackBar('点击地图添加标记，点击标记删除');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AddRemoveMarkerPage.title)),
      body: AMapFlutter(
        initCameraPosition: CameraPosition(
          position: Position(latitude: 39.984120, longitude: 116.307484),
          zoom: 17.2,
        ),
        onMapCreated: (controller) => this.controller = controller,
        onMapPress: (position) => onTap(position),
        onMapLongPress: (position) => onTap(position),
        onPoiClick: (poi) => onTap(poi.position),
        onMarkerClick: (markerId) => onMarkerClick(markerId),
        onMarkerDragEnd: (markerId, position) =>
            context.alert('${position.latitude}, ${position.longitude}'),
      ),
    );
  }

  void onTap(Position position) async {
    final String markerId = 'marker_id_${_markerIdCounter++}';
    final marker = Marker(
      id: markerId,
      position: position,
      bitmap: Bitmap(
        asset: "assets/map-marker.png",
      ),
      count: 5,
      pois: [],
    );
    markers[markerId] = marker;
    controller.addMarker(marker);
    final region = await controller.getVisibleMapRectBounds();
    debugPrint("返回区域：$region");
    debugPrint("返回区域：${region.north}");
    debugPrint("返回区域：${region.east}");
  }

  void onMarkerClick(String markerId) {
    controller.removeMarker(markerId);
    markers.remove(markerId);
  }
}
