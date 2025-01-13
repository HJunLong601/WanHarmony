import Network from '../net/NetworkUtils';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Button("test").onClick(async ()=>{
        // Network.getInstance().get<string>("banner/json",{
        //   onResult(result){
        //     console.log(`ward : ${result.errorCode} ${result.errorMsg} ${result.data}`)
        //   }
        // })

        let tmp = await Network.getInstance().getAsync<string>("banner/json")
        console.log(`ward : ${tmp.errorCode} ${tmp.errorMsg} ${tmp.data}`)
      })

    }
    .height('100%')
    .width('100%')
  }
}