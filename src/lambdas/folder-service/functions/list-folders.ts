import { response } from '../../../utils/responseHandler';
import repository from '../repository';

export const listFolders = async () => {
  const folders = await repository.listFolders();

  return response({ data: { folders } });
};
