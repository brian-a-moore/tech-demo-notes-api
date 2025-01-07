import { APIGatewayProxyEvent } from "aws-lambda";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";
import { Folder } from "../db/type";
import repository from "../repository";

export const updateFolder = async (event: APIGatewayProxyEvent) => {
  const folderId = event.pathParameters?.folderId;
  const update = event.body as unknown as Partial<Folder>;

  if (!folderId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: "Folder ID is required" },
    });

  await repository.updateFolder(folderId, update);

  return response({});
};
