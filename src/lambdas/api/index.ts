import middy from '@middy/core';
import cors from '@middy/http-cors';
import httpErrorHandler from '@middy/http-error-handler';
import jsonBodyParser from '@middy/http-json-body-parser';
import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { HTTP_METHOD, STATUS_CODE } from '../../constants';
import { response } from '../../utils/responseHandler';
import {
  createFolder,
  createNote,
  deleteFolder,
  deleteNote,
  getFolder,
  getNote,
  updateFolder,
  updateNote,
} from './functions';
import { listFolders } from './functions/list-folders';

const apiHandler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
  try {
    const { httpMethod, path } = event;

    // Note routes
    if (path.includes('note')) {
      switch (httpMethod) {
        case HTTP_METHOD.POST:
          return await createNote(event);
        case HTTP_METHOD.DELETE:
          return await deleteNote(event);
        case HTTP_METHOD.GET:
          return await getNote(event);
        case HTTP_METHOD.PUT:
          return await updateNote(event);
        default:
          return response({ status: STATUS_CODE.METHOD_NOT_ALLOWED });
      }
    }
    // Folder routes
    else if (path.includes('folder')) {
      switch (httpMethod) {
        case HTTP_METHOD.POST:
          return await createFolder(event);
        case HTTP_METHOD.DELETE:
          return await deleteFolder(event);
        case HTTP_METHOD.GET: {
          const folderId = event.pathParameters?.folderId;
          if (folderId) {
            return await getFolder(event);
          } else {
            return await listFolders();
          }
        }
        case HTTP_METHOD.PUT:
          return await updateFolder(event);
        default:
          return response({ status: STATUS_CODE.METHOD_NOT_ALLOWED });
      }
    }
    // Catch-all
    else {
      return response({ status: STATUS_CODE.NOT_FOUND });
    }
  } catch (e: any | unknown) {
    console.error(e);
    return response({ status: STATUS_CODE.SERVER_ERROR });
  }
};

export const handler = middy(apiHandler).use(jsonBodyParser()).use(httpErrorHandler()).use(cors());
