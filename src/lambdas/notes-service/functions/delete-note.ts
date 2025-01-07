import { APIGatewayProxyEvent } from "aws-lambda";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";
import repository from "../repository";

export const deleteNote = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;
  const noteId = event.pathParameters?.noteId;

  if (!folderId || !noteId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: "Folder and Note IDs are required" },
    });

  await repository.deleteNote(folderId, noteId);

  return response({});
};
