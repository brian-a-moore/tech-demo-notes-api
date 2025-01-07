import { APIGatewayProxyEvent } from "aws-lambda";
import { response } from "../../../utils/responseHandler";
import { Note } from "../db/type";
import repository from "../repository";

export const createNote = async (event: APIGatewayProxyEvent) => {
  const newNote = event.body as unknown as Note;
  const noteId = await repository.createNote(newNote);

  return response({ data: { noteId } });
};
