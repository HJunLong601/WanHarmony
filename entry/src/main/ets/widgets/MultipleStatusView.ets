export enum ViewStatus {
  LOADING,
  CONTENT,
  ERROR,
  EMPTY
}


@Component
export struct MultipleStatusView {
  @Prop viewStatus: ViewStatus;
  @BuilderParam content: () => void;
  @Prop showLoading: boolean;
  onReload ?: () => void;

  build() {

    Stack() {
      if (this.viewStatus === ViewStatus.LOADING) {
        LoadingProgress()
          .width(50)
          .height(50)
          .color($r("app.color.theme_color"))
      } else if (this.viewStatus === ViewStatus.CONTENT) {
        this.content();
        if (this.showLoading) {
          LoadingProgress()
            .width(50)
            .height(50)
            .color($r("app.color.white"))
        }
      } else if (this.viewStatus === ViewStatus.ERROR) {
        Stack() {
          Text("加载失败，点击重试")
        }
        .width('100%')
        .height('100%')
        .onClick(() => {
          if (this.onReload) {
            this.onReload();
          }
        })
      } else {
        Stack() {
          Text("这里什么都没有")
        }
        .width('100%')
        .height('100%')
        .onClick(() => {
          if (this.onReload) {
            this.onReload();
          }
        })
      }
    }
    .width('100%')
    .height('100%')

  }
}