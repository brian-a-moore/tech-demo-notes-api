import crypto from "crypto";
import { Note } from "../db/type";

export const createNote = async (note: Note) => {
  const noteId = crypto.randomUUID();

  return noteId;
};
