import { APIGatewayProxyEvent } from 'aws-lambda';
import { ZodError } from 'zod';
import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { FolderModel } from '../db/model';
import { FolderSchema } from '../db/schema';
import { Folder } from '../db/type';

export const createFolder = async (event: APIGatewayProxyEvent) => {
  const data = JSON.parse(event.body as string) as unknown as Folder;

  try {
    FolderSchema.parse(data || '{}');
  } catch (e) {
    const { message } = e as ZodError;
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message },
    });
  }

  const folderId = crypto.randomUUID();

  const newFolder = new FolderModel({
    PK: `${DB_KEY.FOLDER}#${folderId}`,
    SK: `${DB_KEY.FOLDER}#${folderId}`,
    ...data,
  });

  await newFolder.save();

  return response({ data: { folderId } });
};
