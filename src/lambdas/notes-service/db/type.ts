import { z } from "zod";
import { DynamoRecord } from "../../../constants";
import { NoteSchema } from "./schema";

export type Note = z.infer<typeof NoteSchema>;
export type NoteRecord = Note & DynamoRecord;
