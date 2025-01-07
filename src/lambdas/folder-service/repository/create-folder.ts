import crypto from "crypto";
import { DB_KEY } from "../../../constants";
import { FolderModel } from "../db/model";
import { Folder } from "../db/type";

export const createFolder = async (folder: Folder) => {
  const folderId = crypto.randomUUID();

  const newFolder = new FolderModel({
    PK: `${DB_KEY.FOLDER}#${folderId}`,
    SK: `${DB_KEY.FOLDER}#${folderId}`,
    ...folder,
  });

  await newFolder.save();

  return folderId;
};
