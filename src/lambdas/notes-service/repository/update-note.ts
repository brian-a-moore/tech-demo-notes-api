import { DB_KEY } from "../../../constants";
import { NoteModel } from "../db/model";
import { Note } from "../db/type";

export const updateNote = async (
  noteId: string,
  { folderId, ...update }: Partial<Note>,
) => {
  await NoteModel.update(
    {
      PK: `${DB_KEY.NOTE}${noteId}`,
      SK: `${DB_KEY.FOLDER}${folderId}`,
    },
    update,
  );
};
