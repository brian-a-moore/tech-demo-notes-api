import z from "zod";

export const FolderSchema = z.object({
  title: z.string().min(1).max(256),
});
