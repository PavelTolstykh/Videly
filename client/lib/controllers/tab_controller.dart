import 'package:client/domain/models/tab.dart';
import 'package:client/widgets/navBar/tab_navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MyTabController extends ControllerMVC {
  final Map<TabItem, List<Object>> _navigatorKeys = {
    TabItem.HOME: [GlobalKey<NavigatorState>(), const HomeTab()],
    TabItem.HISTORY: [GlobalKey<NavigatorState>(), const HistoryTab()],
    TabItem.SUBSCRIPTIONS: [
      GlobalKey<NavigatorState>(),
      const SubscriptionsTab()
    ],
    TabItem.ACCOUNT: [GlobalKey<NavigatorState>(), const AccountTab()],
  };

  //Map<TabItem, GlobalKey> get navigatorKeys => _navigatorKeys;

  // текущий выбранный элемент
  var _currentTab = TabItem.HOME;

  // то же самое и для текущего выбранного пункта меню
  TabItem get currentTab => _currentTab;

  // библиотека mvc_pattern
  // предоставляет доступ к setState
  void selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  Future<bool> switchTabOnBackButtonClicked() async {
    // когда мы находимся на первом пункте меню (главная)
    // и нажимаем кнопку Back, то сразу выходим из приложения
    // в противном случае выбранный элемент меню переключается
    // на предыдущий:
    //  c аккаунта на историю просмотров,
    //  с историю просмотров на подписки,
    //  с подписок на главную
    if (currentTab != TabItem.HOME) {
      if (currentTab == TabItem.ACCOUNT) {
        selectTab(TabItem.HISTORY);
      } else if (currentTab == TabItem.HISTORY) {
        selectTab(TabItem.SUBSCRIPTIONS);
      } else {
        selectTab(TabItem.HOME);
      }
      return false;
    } else {
      return true;
    }
  }

  // Создание одного из экранов - посты, альбомы или задания
  Widget createTabPage(TabItem tabItem) {
    return _buildOffstageNavigator(tabItem);
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      // Offstage работает следующим образом:
      // если это не текущий выбранный элемент, то его нужно скрыть
      offstage: currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]?.first as GlobalKey<NavigatorState>,
        tabItem: tabItem,
      ),
    );
  }

  // построение пункта меню
  BottomNavigationBarItem buildItem(TabItem item) {
    return BottomNavigationBarItem(
      icon: Icon(
        _tabIcon(item),
        color: _tabColor(item),
      ),
      label: _tabLabel(item),
    );
  }

  String _tabLabel(TabItem item) => (_navigatorKeys[item]?.last as Tab).name;

  IconData _tabIcon(TabItem item) => (_navigatorKeys[item]?.last as Tab).icon;

  Color _tabColor(TabItem item) {
    return currentTab == item
        ? (_navigatorKeys[item]?.last as Tab).selectedItemColor
        : (_navigatorKeys[item]?.last as Tab).unselectedItemColor;
  }
}
