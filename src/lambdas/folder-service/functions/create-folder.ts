import { APIGatewayProxyEvent } from "aws-lambda";
import { response } from "../../../utils/responseHandler";
import { Folder } from "../db/type";
import repository from "../repository";

export const createFolder = async (event: APIGatewayProxyEvent) => {
  const newFolder = event.body as unknown as Folder;
  const folderId = await repository.createFolder(newFolder);

  return response({ data: { folderId } });
};
