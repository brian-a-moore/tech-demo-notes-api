import { APIGatewayProxyEvent } from 'aws-lambda';
import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { transformNoteToNoteItem } from '../../../utils/transforms';
import { NoteModel } from '../db/model';
import { NoteRecord } from '../db/type';

export const getNote = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;
  const noteId = event.pathParameters?.noteId;

  if (!noteId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: 'Note ID is required' },
    });

  const records = await NoteModel.query({
    PK: `${DB_KEY.NOTE}${noteId}`,
    SK: `${DB_KEY.FOLDER}${folderId}`,
  }).exec();

  if (!records || records.count === 0) {
    return response({ status: STATUS_CODE.NOT_FOUND });
  }

  const note = transformNoteToNoteItem(records[0] as unknown as NoteRecord);

  return response({ data: { note } });
};
