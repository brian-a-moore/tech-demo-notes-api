import { APIGatewayProxyEvent } from "aws-lambda";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";
import repository from "../repository";

export const deleteNote = async (event: APIGatewayProxyEvent) => {
  const noteId = event.pathParameters?.noteId;

  if (!noteId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: "Note ID is required" },
    });

  await repository.deleteNote(noteId);

  return response({});
};
