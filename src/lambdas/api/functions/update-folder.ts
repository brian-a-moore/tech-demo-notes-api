import { APIGatewayProxyEvent } from 'aws-lambda';
import { ZodError } from 'zod';
import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { FolderModel } from '../db/model';
import { FolderSchema } from '../db/schema';
import { Folder } from '../db/type';

export const updateFolder = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;
  const update = event.body as unknown as Partial<Folder>;

  if (!folderId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: 'Folder ID is required' },
    });

  try {
    FolderSchema.parse(update || '{}');
  } catch (e) {
    const { message } = e as ZodError;
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message },
    });
  }

  await FolderModel.update(
    {
      PK: `${DB_KEY.FOLDER}${folderId}`,
      SK: `${DB_KEY.FOLDER}${folderId}`,
    },
    update,
  );

  return response({});
};
