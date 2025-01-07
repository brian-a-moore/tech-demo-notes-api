import z from "zod";

export const NoteSchema = z.object({
  title: z.string().min(1).max(256),
  body: z.string().min(1).max(8192),
});
