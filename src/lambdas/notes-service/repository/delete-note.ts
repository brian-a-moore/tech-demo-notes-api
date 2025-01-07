import { DB_KEY } from "../../../constants";
import { NoteModel } from "../db/model";

export const deleteNote = async (noteId: string) => {
  await NoteModel.delete({
    PK: `${DB_KEY.FOLDER}#${noteId}`,
    SK: `${DB_KEY.FOLDER}#${noteId}`,
  });
};
