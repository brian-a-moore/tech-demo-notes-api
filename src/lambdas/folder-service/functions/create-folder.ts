import { APIGatewayProxyEvent } from "aws-lambda";
import { ZodError } from "zod";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";
import { FolderSchema } from "../db/schema";
import { Folder } from "../db/type";
import repository from "../repository";

export const createFolder = async (event: APIGatewayProxyEvent) => {
  const newFolder = JSON.parse(event.body as string) as unknown as Folder;

  try {
    FolderSchema.parse(newFolder || "{}");
  } catch (e) {
    const { message } = e as ZodError;
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message },
    });
  }

  const folderId = await repository.createFolder(newFolder);

  return response({ data: { folderId } });
};
