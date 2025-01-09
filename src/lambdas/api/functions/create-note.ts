import { APIGatewayProxyEvent } from 'aws-lambda';
import { ZodError } from 'zod';
import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { NoteModel } from '../db/model';
import { NoteSchema } from '../db/schema';
import { Note } from '../db/type';

export const createNote = async (event: APIGatewayProxyEvent) => {
  const data = event.body as unknown as Note;

  try {
    NoteSchema.parse(data || '{}');
  } catch (e) {
    const { message } = e as ZodError;
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message },
    });
  }

  const noteId = crypto.randomUUID();

  const { folderId, ...rest } = data;

  const newNote = new NoteModel({
    PK: `${DB_KEY.NOTE}#${noteId}`,
    SK: `${DB_KEY.FOLDER}#${folderId}`,
    ...rest,
  });

  await newNote.save();

  return response({ data: { noteId } });
};
