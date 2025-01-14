import { hilog } from '@kit.PerformanceAnalysisKit'


class LogUtils{


  d(tag : string = "WanHarmony",msg : string){
    hilog.info(0,tag,msg)
  }

  i(tag : string = "WanHarmony",msg : string){
    hilog.info(0,tag,msg)
  }

  w(tag : string = "WanHarmony",msg : string){
    hilog.info(0,tag,msg)
  }

  e(tag : string = "WanHarmony",msg : string){
    hilog.info(0,tag,msg)
  }

}


export const Log = new LogUtils()