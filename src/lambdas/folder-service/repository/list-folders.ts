import { DB_KEY } from '../../../constants';
import { FolderModel } from '../db/model';
import { FolderItem, FolderRecord } from '../db/type';

const transformFoldersToFolderItems = (records: FolderRecord[]): FolderItem[] => {
  return records.map((r) => {
    const [, folderId] = r.PK.split('#');
    return {
      folderId,
      title: r.title,
    };
  });
};

export const listFolders = async (): Promise<FolderItem[]> => {
  const records = await FolderModel.scan('PK').beginsWith(`${DB_KEY.FOLDER}#`).exec();

  if (!records || records.count === 0) {
    return [];
  }

  return transformFoldersToFolderItems(records as unknown as FolderRecord[]);
};
