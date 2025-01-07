import { DB_KEY } from "../../../constants";
import { NoteModel } from "../db/model";
import { Note } from "../db/type";

export const updateNote = async (noteId: string, update: Partial<Note>) => {
  await NoteModel.update(
    {
      PK: `${DB_KEY.FOLDER}${noteId}`,
      SK: `${DB_KEY.FOLDER}${noteId}`,
    },
    update,
  );
};
