import { DB_KEY } from "../../../constants";
import { FolderModel } from "../db/model";

export const deleteFolder = async (folderId: string) => {
  await FolderModel.delete({
    PK: `${DB_KEY.FOLDER}#${folderId}`,
    SK: `${DB_KEY.FOLDER}#${folderId}`,
  });
};
