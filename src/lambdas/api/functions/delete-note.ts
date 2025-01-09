import { APIGatewayProxyEvent } from 'aws-lambda';
import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { NoteModel } from '../db/model';

export const deleteNote = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;
  const noteId = event.pathParameters?.noteId;

  if (!folderId || !noteId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: 'Folder and Note IDs are required' },
    });

  await NoteModel.delete({
    PK: `${DB_KEY.NOTE}#${noteId}`,
    SK: `${DB_KEY.FOLDER}#${folderId}`,
  });

  return response({});
};
