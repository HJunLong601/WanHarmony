import { AbilityConstant, AbilityStage, Want } from '@kit.AbilityKit';
import { Log } from '../utils/LogUtils';


const TAG = "WanAbilityStage"


/**
 * 模块级别的 Context 类似android 里面的模块级别的application
 * doc: https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/abilitystage-0000001427584604-V2
 */
export default class WanAbilityStage extends AbilityStage {


  onCreate(): void {

    Log.i(TAG,"onCreate")
    Log.d(TAG,`module name : ${this.context.currentHapModuleInfo.name}`)

  }

  onAcceptWant(want: Want): string {
    return super.onAcceptWant(want);
  }

  onNewProcessRequest(want: Want): string {
    Log.i(TAG,`onNewProcessRequest ${want.uri}`)
    return super.onNewProcessRequest(want);
  }

  // onConfigurationUpdate(newConfig: Configuration): void {
  //   Log.i(TAG,`onConfigurationUpdate}`)
  //   super.onConfigurationUpdate(newConfig);
  // }

  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
    super.onMemoryLevel(level);
    Log.i(TAG,`onMemoryLevel :${level}}`)
  }

  onDestroy(): void {
    super.onDestroy();
    Log.i(TAG,"onDestroy")
  }
}