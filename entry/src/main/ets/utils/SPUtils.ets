

import { Context } from '@kit.AbilityKit';
import { MMKV } from '@tencent/mmkv';
import { Log } from './LogUtils';

const TAG = "SPUtils"

class StorageUtils {


  private mmkv : MMKV | undefined = undefined

  init(context : Context){
    let appCtx = context.getApplicationContext();
    let mmkvRootDir = MMKV.initialize(appCtx);
    Log.i(TAG,`mmkv rootDir: ${mmkvRootDir}`);
    this.mmkv = MMKV.defaultMMKV()
  }

  putString(key : string,value : string){
    this.mmkv?.encodeString(key,value)
  }

  getString(key : string,fallback : string = "") : string{

    let result = this.mmkv?.decodeString(key,fallback)

    if(result) return result;

    return fallback
  }

  putNumber(key : string,value : number){
    this.mmkv?.encodeInt32(key,value)
  }

  getNumber(key : string,fallback : number = 0) : number{

    let result = this.mmkv?.decodeInt32(key,fallback)

    if(result) return result;

    return fallback
  }

  putBool(key : string,value : boolean){
    this.mmkv?.encodeBool(key,value)
  }

  getBool(key : string,fallback : boolean = false) : boolean{

    let result = this.mmkv?.decodeBool(key,fallback)

    if(result != undefined) return result;

    return fallback
  }


}

export const SPUtils = new StorageUtils()