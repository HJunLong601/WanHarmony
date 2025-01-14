import { http } from '@kit.NetworkKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { Log } from '../utils/LogUtils';
import { IHttpCallback } from './IHttpCallback';
import { Response } from './Response';


/**
 * 官方文档 : https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/http-request-V5
 */

const TAG = "Network";
const HOST : string = "https://www.wanandroid.com/";

class Network{
  private static instance: Network;

  private constructor() {
  }

  static getInstance(): Network {
    if (Network.instance === undefined) {
      Network.instance = new Network();
    }
    return Network.instance;
  }

  async getAsync<T>(path : string) : Promise<Response<T>>{
    return new Promise<Response<T>>((resolve, reject) => {
      let request = http.createHttp()
      let url = path.startsWith("http") ? path : `${HOST}${path}`

      Log.i(TAG,`start get path : ${url}`)

      request.request(url,
        {
          method : http.RequestMethod.GET,
          connectTimeout: 10000,
          readTimeout: 10000
        },(err,data) => {
          let res = new Response<T>()
          if (!err && data.responseCode === 200) {
            handleResultAsync<T>(path, data, res, resolve);
          } else {
            hilog.error(0, TAG, `request error, path: ${path}, error: ${JSON.stringify(err)}`)
            res.errorCode = data?.responseCode ?? -1
            res.errorMsg = err?.message ?? ""
            resolve(res)
          }
        })

    })
  }

  get<T>(path : string,callback : IHttpCallback<T>){

    let request = http.createHttp()
    let url = path.startsWith("http") ? path : `${HOST}${path}`

    Log.i(TAG,`start get path : ${url}`)

    request.request(url,
      {
        method : http.RequestMethod.GET,
        connectTimeout: 10000,
        readTimeout: 10000
      },(err,data) => {
        let res = new Response<T>()
        if (!err && data.responseCode === 200) {
          handleResult<T>(path, data, res, callback);
        } else {
          hilog.error(0, TAG, `request error, path: ${path}, error: ${JSON.stringify(err)}`)
          res.errorCode = data?.responseCode ?? -1
          res.errorMsg = err?.message ?? ""
          callback.onResult(res)
        }
      })

  }

  async postAsync<T>(path : string) : Promise<Response<T>>{
    return new Promise<Response<T>>((resolve, reject) => {
      let request = http.createHttp()
      let url = path.startsWith("http") ? path : `${HOST}${path}`

      Log.i(TAG,`start get path : ${url}`)

      request.request(url,
        {
          method : http.RequestMethod.POST,
          connectTimeout: 10000,
          readTimeout: 10000
        },(err,data) => {
          let res = new Response<T>()
          if (!err && data.responseCode === 200) {
            handleResultAsync<T>(path, data, res, resolve);
          } else {
            hilog.error(0, TAG, `request error, path: ${path}, error: ${JSON.stringify(err)}`)
            res.errorCode = data?.responseCode ?? -1
            res.errorMsg = err?.message ?? ""
            resolve(res)
          }
        })

    })
  }

  post<T>(path : string,callback : IHttpCallback<T>) {

    let request = http.createHttp()
    let url = path.startsWith("http") ? path : `${HOST}${path}`

    Log.i(TAG,`start get path : ${url}`)

    request.request(url,
      {
        method : http.RequestMethod.POST,
        connectTimeout: 10000,
        readTimeout: 10000
      },(err,data) => {
        let res = new Response<T>()
        if (!err && data.responseCode === 200) {
          handleResult<T>(path, data, res, callback);
        } else {
          hilog.error(0, TAG, `request error, path: ${path}, error: ${JSON.stringify(err)}`)
          res.errorCode = data?.responseCode ?? -1
          res.errorMsg = err?.message ?? ""
          callback.onResult(res)
        }
      })

  }

}

function handleResultAsync<T>(path: string, data: http.HttpResponse, res: Response<T>, resolve : (value: Response<T>)=> void) {
  Log.i(TAG, `request success, path: ${path}, result: ${JSON.stringify(data)}`);

  if (data.resultType === http.HttpDataType.STRING) {
    let result: Response<T> = JSON.parse(data.result as string);
    res.errorCode = result.errorCode;
    res.errorMsg = result.errorMsg;
    res.data = result.data;
    resolve(res);
  } else if (data.resultType === http.HttpDataType.OBJECT) {
    const result = data.result as Response<T>;
    res.errorCode = result.errorCode;
    res.errorMsg = result.errorMsg;
    res.data = result.data;
    resolve(res);
  } else {
    res.errorCode = -1;
    res.errorMsg = `UnSupport data type: ${data.resultType}`;
    resolve(res);
  }
}

function handleResult<T>(path: string, data: http.HttpResponse, res: Response<T>, callback: IHttpCallback<T>) {
  Log.i(TAG, `request success, path: ${path}, result: ${JSON.stringify(data.result)}`);

  if (data.resultType === http.HttpDataType.STRING) {
    let result: Response<T> = JSON.parse(data.result as string);
    res.errorCode = result.errorCode;
    res.errorMsg = result.errorMsg;
    res.data = result.data;
    callback.onResult(res);
  } else if (data.resultType === http.HttpDataType.OBJECT) {
    const result = data.result as Response<T>;
    res.errorCode = result.errorCode;
    res.errorMsg = result.errorMsg;
    res.data = result.data;
    callback.onResult(res);
  } else {
    res.errorCode = -1;
    res.errorMsg = `UnSupport data type: ${data.resultType}`;
    callback.onResult(res);
  }
}

export const API = Network.getInstance()



