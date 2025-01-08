import { DB_KEY } from '../../../constants';
import { NoteModel } from '../db/model';

export const deleteNote = async (folderId: string, noteId: string) => {
  await NoteModel.delete({
    PK: `${DB_KEY.NOTE}#${noteId}`,
    SK: `${DB_KEY.FOLDER}#${folderId}`,
  });
};
