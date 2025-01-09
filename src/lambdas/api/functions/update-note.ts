import { APIGatewayProxyEvent } from 'aws-lambda';
import { ZodError } from 'zod';
import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { NoteModel } from '../db/model';
import { NoteSchema } from '../db/schema';
import { Note } from '../db/type';

export const updateNote = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;
  const noteId = event.pathParameters?.noteId;
  const update = event.body as unknown as Partial<Note>;

  if (!noteId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: 'Note ID is required' },
    });

  try {
    NoteSchema.parse(update || '{}');
  } catch (e) {
    const { message } = e as ZodError;
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message },
    });
  }

  await NoteModel.update(
    {
      PK: `${DB_KEY.NOTE}${noteId}`,
      SK: `${DB_KEY.FOLDER}${folderId}`,
    },
    update,
  );

  return response({});
};
