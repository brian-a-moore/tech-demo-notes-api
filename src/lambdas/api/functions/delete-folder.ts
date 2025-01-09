import { APIGatewayProxyEvent } from 'aws-lambda';
import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { FolderModel } from '../db/model';

export const deleteFolder = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;

  if (!folderId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: 'Folder ID is required' },
    });

  await FolderModel.delete({
    PK: `${DB_KEY.FOLDER}#${folderId}`,
    SK: `${DB_KEY.FOLDER}#${folderId}`,
  });

  return response({});
};
