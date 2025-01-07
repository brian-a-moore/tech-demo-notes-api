import crypto from "crypto";
import { Folder } from "../db/type";

export const createFolder = async (folder: Folder) => {
  const folderId = crypto.randomUUID();

  return folderId;
};
