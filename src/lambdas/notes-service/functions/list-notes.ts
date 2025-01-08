import { APIGatewayProxyEvent } from 'aws-lambda';
import { STATUS_CODE } from '../../../constants';
import { response } from '../../../utils/responseHandler';
import repository from '../repository';

export const listNotes = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;

  if (!folderId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: 'Folder ID is required' },
    });

  const notes = await repository.listNotes(folderId);

  return response({ data: { notes } });
};
