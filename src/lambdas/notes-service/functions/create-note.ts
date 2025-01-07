import { APIGatewayProxyEvent } from "aws-lambda";
import { ZodError } from "zod";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";
import { NoteSchema } from "../db/schema";
import { Note } from "../db/type";
import repository from "../repository";

export const createNote = async (event: APIGatewayProxyEvent) => {
  const newNote = event.body as unknown as Note;

  try {
    NoteSchema.parse(newNote || "{}");
  } catch (e) {
    const { message } = e as ZodError;
    return response({
      status: STATUS_CODE.BAD_REQUEST,
      data: { message },
    });
  }

  const noteId = await repository.createNote(newNote);

  return response({ data: { noteId } });
};
