import { APIGatewayProxyEvent } from "aws-lambda";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";
import repository from "../repository";

export const deleteFolder = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;

  if (!folderId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: "Folder ID is required" },
    });

  await repository.deleteFolder(folderId);

  return response({});
};
