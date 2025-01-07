import { DB_KEY } from "../../../constants";
import { FolderModel } from "../db/model";
import { Folder } from "../db/type";

export const updateFolder = async (
  folderId: string,
  update: Partial<Folder>,
) => {
  await FolderModel.update(
    {
      PK: `${DB_KEY.FOLDER}${folderId}`,
      SK: `${DB_KEY.FOLDER}${folderId}`,
    },
    update,
  );
};
