import middy from '@middy/core';
import cors from '@middy/http-cors';
import httpErrorHandler from '@middy/http-error-handler';
import jsonBodyParser from '@middy/http-json-body-parser';
import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { HTTP_METHOD, STATUS_CODE } from '../../constants';
import { response } from '../../utils/responseHandler';
import { createFolder, deleteFolder, listFolders, updateFolder } from './functions';
import { getFolder } from './functions/get-folder';

const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
  try {
    const { httpMethod } = event;
    const folderId = event.pathParameters?.folderId;

    switch (httpMethod) {
      case HTTP_METHOD.POST:
        return await createFolder(event);
      case HTTP_METHOD.DELETE:
        return await deleteFolder(event);
      case HTTP_METHOD.GET:
        if (folderId) {
          return await getFolder(event);
        } else {
          return await listFolders();
        }
      case HTTP_METHOD.PUT:
        return await updateFolder(event);
      default:
        return response({ status: STATUS_CODE.METHOD_NOT_ALLOWED });
    }
  } catch (e: any | unknown) {
    console.error(e);
    return response({ status: STATUS_CODE.SERVER_ERROR });
  }
};

export const main = middy(handler).use(jsonBodyParser()).use(httpErrorHandler()).use(cors());
