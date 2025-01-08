import { DB_KEY, STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { NoteModel } from '../db/model';
import { NoteItem, NoteRecord } from '../db/type';

const transformNoteToNoteItem = (r: NoteRecord): NoteItem => {
  const [, noteId] = r.PK.split('#');
  const [, folderId] = r.SK.split('#');
  return {
    noteId,
    folderId,
    title: r.title,
    body: r.body,
  };
};

export const getNote = async (folderId: string, noteId: string) => {
  const records = await NoteModel.query({
    PK: `${DB_KEY.NOTE}${noteId}`,
    SK: `${DB_KEY.FOLDER}${folderId}`,
  }).exec();

  if (!records || records.count === 0) {
    return response({ status: STATUS_CODE.NOT_FOUND });
  }

  return transformNoteToNoteItem(records[0] as unknown as NoteRecord);
};
