import 'package:flutter/material.dart';
import '../../widgets/layouts/appbar_layout.dart';
import '../../widgets/styles/colors.dart' as colors;
import '../../widgets/styles/borders.dart' as borders;
import '../../api/guides.dart' as api;
import '../../app_state.dart';
import '../../types/guide_article_data.dart';

class GuideArticle extends StatefulWidget {
  @override
  _GuideArticleState createState() => _GuideArticleState();
}

class _GuideArticleState extends State<GuideArticle> {
  final GlobalKey _globalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final String _id = appState.routeParam ?? '1';

  String _appBarColor = 'transparent';

  String _imagePath = '';
  String _description = '';
  bool _isReadPosted = false;
  double _imageScale = 1;

  Future getGuideContentById() async {
    try {
      final data = await api.getGuideContentById(_id);
      GuideArticleData content = GuideArticleData.fromJson(data);

      setState(() {
        _imagePath = 'https://picsum.photos/250?image=9';
        _description = content.description;
      });
    } catch (e) {
      print(e);
    }
  }

  Future postGuideContentRead() async {
    try {
      await api.postGuideContentRead(_id);
      await appState.getGuideUnreadCnt();
    } catch (e) {
      print(e);
    }
  }

  void hadleScroll() {
    double offset = _scrollController.offset;

    // Scale image
    setState(() {
      _imageScale = offset < 0
          ? (1 + -offset * 0.005)
          : offset < 1000
              ? (1 + offset * 0.001)
              : 2;

      _appBarColor = offset >= 400 ? 'white' : 'transparent';
    });

    // Post read
    if (_isReadPosted == false &&
        offset >= (_scrollController.position.maxScrollExtent * 0.7)) {
      _isReadPosted = true;
      postGuideContentRead();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(hadleScroll);
    getGuideContentById();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarLayout(
        title: '',
        extendBodyBehindAppBar: true,
        appBarColor: _appBarColor,
        globalKey: _globalKey,
        scrollController: _scrollController,
        body: Container(
            child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 75 / 84,
              child: Stack(
                children: <Widget>[
                  Transform.scale(
                      scale: _imageScale,
                      child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.network(_imagePath, fit: BoxFit.cover)))
                ],
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(color: colors.white),
                padding:
                    EdgeInsets.only(top: 34, left: 20, right: 20, bottom: 79),
                child: Text(_description)),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                decoration:
                    BoxDecoration(color: colors.copyRightWarningBackground),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('닥터밀로 컨텐츠의 지식재산권 안내',
                        style: TextStyle(
                            color: colors.helperLabel,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            height: 1.47)),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                          ' 닥터밀로는 정확한 키토제닉으로 놀라운 변화와 경험를 제공하고자 노력하고 있습니다. 위 식단가이드는 제품을 구매한 분들에게 제공되는 상업용 콘텐츠로, 닥터밀로의 국내 고객 상담 2만건 이상의 실사례 및 바이오 지표 변화값을 바탕으로 한국인에게 적합한 키토를 안내하고자 제작되었습니다.',
                          style: TextStyle(
                              color: colors.helperLabel,
                              fontSize: 13,
                              height: 1.47)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                          ' 닥터밀로의 지식재산권을 침해하는 무단게제, 무단카피, 무단인용 등의 행위를 허용하지 않습니다. 해당 권리에 대해 궁금한 점이 있는 경우, 반드시 법률 전문가에 문의하세요. 출처를 명확하게 밝히지 않거나, 개인의 콘텐츠로 오인되는 방식의 게제를 한 경우, 지식재산권을 침해했거나, 침해에 준하는 기타 행위를 한 경우 닥터밀로의 서비스를 더 이상 이용할 수 없으며 법적 처벌을 받을 수 있습니다.',
                          style: TextStyle(
                              color: colors.helperLabel,
                              fontSize: 13,
                              height: 1.47)),
                    )
                  ],
                ))
          ],
        )));
  }
}
