import { Log } from '../utils/LogUtils'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State fontColor: ResourceColor = Color.Black
  @State selectedFontColor: ResourceColor = $r("app.color.theme_color")
  tabText: Array<string> = ["首页", "问答", "体系", "我的"]
  selectedIcons =
    [$r("app.media.icon_home"), $r("app.media.icon_wenda"), $r("app.media.icon_book"), $r("app.media.icon_login_blue")]
  unselectIcons = [$r("app.media.icon_home_grey"), $r("app.media.icon_wenda_gray"), $r("app.media.icon_book_grey"),
    $r("app.media.icon_login_gray")]

  aboutToAppear(): void {
    Log.d("ward", "aboutToAppear")
  }

  @Builder
  tabBuilder(index: number) {
    Column() {
      Image(this.currentIndex === index ? this.selectedIcons[index] : this.unselectIcons[index])
        .width(18)
        .height(18)
        .margin({ bottom: 4 })
        .objectFit(ImageFit.Contain)
      Text(this.tabText[index])
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%')
  }

  build() {

    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        RelativeContainer() {
          Text(this.tabText[0])
            .fontSize(36)
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center }
            })
        }.width("100%").height("100%")
      }.tabBar(this.tabBuilder(0))

      TabContent() {
        RelativeContainer() {
          Text(this.tabText[1])
            .fontSize(36)
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center }
            })
        }.width("100%").height("100%")
      }.tabBar(this.tabBuilder(1))

      TabContent() {
        RelativeContainer() {
          Text(this.tabText[2])
            .fontSize(36)
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center }
            })
        }.width("100%").height("100%")
      }.tabBar(this.tabBuilder(2))

      TabContent() {
        RelativeContainer() {
          Text(this.tabText[3])
            .fontSize(36)
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center }
            })
        }.width("100%").height("100%")
      }.tabBar(this.tabBuilder(3))
    }.onChange((index) => {
      this.currentIndex = index
    })
  }
}