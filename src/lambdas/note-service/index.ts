import middy from '@middy/core';
import cors from '@middy/http-cors';
import httpErrorHandler from '@middy/http-error-handler';
import jsonBodyParser from '@middy/http-json-body-parser';
import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { HTTP_METHOD, STATUS_CODE } from '../../constants';
import { response } from '../../utils/responseHandler';
import { createNote, deleteNote, getNote, listNotes, updateNote } from './functions';

const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
  try {
    const { httpMethod, path } = event;

    switch (httpMethod) {
      case HTTP_METHOD.POST:
        return await createNote(event);
      case HTTP_METHOD.DELETE:
        return await deleteNote(event);
      case HTTP_METHOD.GET:
        if (path.includes('/list')) {
          return await listNotes(event);
        } else {
          return await getNote(event);
        }
      case HTTP_METHOD.PUT:
        return await updateNote(event);
      default:
        return response({ status: STATUS_CODE.METHOD_NOT_ALLOWED });
    }
  } catch (e: any | unknown) {
    console.error(e);
    return response({ status: STATUS_CODE.SERVER_ERROR });
  }
};

export const main = middy(handler).use(jsonBodyParser()).use(httpErrorHandler()).use(cors());
