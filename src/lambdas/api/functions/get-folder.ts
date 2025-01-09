import { APIGatewayProxyEvent } from 'aws-lambda';
import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { transformNoteToNoteItem } from '../../../utils/transforms';
import { NoteModel } from '../db/model';
import { NoteRecord } from '../db/type';

export const getFolder = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;

  if (!folderId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: 'Folder ID is required' },
    });

  const records = await NoteModel.scan('PK')
    .eq(`${DB_KEY.FOLDER}$${folderId}`)
    .filter('SK')
    .beginsWith(DB_KEY.NOTE)
    .exec();

  if (!records || records.count === 0) {
    return response({ data: { notes: [] } });
  }

  const notes = records.map((record) => transformNoteToNoteItem(record as unknown as NoteRecord));

  return response({ data: { notes } });
};
