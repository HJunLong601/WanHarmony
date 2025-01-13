import { BusinessError } from '@kit.BasicServicesKit';
import { Response } from './Response';

export interface IHttpCallback<T> {

  onResult : (result : Response<T>) => void;

}

