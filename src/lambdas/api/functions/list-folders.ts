import { DB_KEY } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import { transformFolderToFolderItem } from '../../../utils/transforms';
import { FolderModel } from '../db/model';
import { FolderRecord } from '../db/type';

export const listFolders = async () => {
  const records = await FolderModel.scan('PK').beginsWith(`${DB_KEY.FOLDER}#`).exec();

  if (!records || records.count === 0) {
    return response({ data: { folders: [] } });
  }

  const folders = records.map((r) => transformFolderToFolderItem(r as unknown as FolderRecord));

  return response({ data: { folders } });
};
