import { APIGatewayProxyEvent } from "aws-lambda";
import { response } from "../../../utils/responseHandler";
import repository from "../repository";

export const listFolders = async (_event: APIGatewayProxyEvent) => {
  const folders = await repository.listFolders();

  return response({ data: { folders } });
};
