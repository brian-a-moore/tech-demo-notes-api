import { APIGatewayProxyEvent } from "aws-lambda";
import { ZodError } from "zod";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";
import { NoteSchema } from "../db/schema";
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

  try {
    NoteSchema.parse(update || "{}");
  } catch (e) {
    const { message } = e as ZodError;
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message },
    });
  }

  await repository.updateNote(noteId, update);

  return response({});
};
