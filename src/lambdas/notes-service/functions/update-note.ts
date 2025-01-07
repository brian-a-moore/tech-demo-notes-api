import { APIGatewayProxyEvent } from "aws-lambda";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";
import { Note } from "../db/type";
import repository from "../repository";

export const updateNote = async (event: APIGatewayProxyEvent) => {
  const noteId = event.pathParameters?.noteId;
  const update = event.body as unknown as Partial<Note>;

  if (!noteId)
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message: "Note ID is required" },
    });

  await repository.updateNote(noteId, update);

  return response({});
};
