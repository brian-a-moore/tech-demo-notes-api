import z from 'zod';

export const FolderSchema = z.object({
  title: z.string().min(1).max(256),
});

export const NoteSchema = z.object({
  title: z.string().min(1).max(256),
  folderId: z.string().uuid(),
  body: z.string().min(1).max(8192),
});
