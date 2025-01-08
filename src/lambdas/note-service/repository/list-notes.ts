import { DB_KEY } from '../../../constants';
import { NoteModel } from '../db/model';
import { NoteItem, NoteRecord } from '../db/type';

const transformNotesToNoteItems = (records: NoteRecord[]): NoteItem[] => {
  return records.map((r) => {
    const [, noteId] = r.PK.split('#');
    const [, folderId] = r.SK.split('#');
    return {
      noteId,
      folderId,
      title: r.title,
      body: r.body,
    };
  });
};

export const listNotes = async (folderId: string) => {
  const records = await NoteModel.scan('PK')
    .eq(`${DB_KEY.FOLDER}$${folderId}`)
    .filter('SK')
    .beginsWith(DB_KEY.NOTE)
    .exec();

  if (!records || records.count === 0) {
    return [];
  }

  return transformNotesToNoteItems(records as unknown as NoteRecord[]);
};
