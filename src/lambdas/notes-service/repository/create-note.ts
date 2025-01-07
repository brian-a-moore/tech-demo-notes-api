import crypto from "crypto";
import { DB_KEY } from "../../../constants";
import { NoteModel } from "../db/model";
import { Note } from "../db/type";

export const createNote = async ({ folderId, ...note }: Note) => {
  const noteId = crypto.randomUUID();

  const newNote = new NoteModel({
    PK: `${DB_KEY.NOTE}#${noteId}`,
    SK: `${DB_KEY.FOLDER}#${folderId}`,
    ...note,
  });

  await newNote.save();

  return noteId;
};
