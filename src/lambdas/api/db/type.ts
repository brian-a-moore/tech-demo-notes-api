import { z } from 'zod';
import { DynamoRecord } from '../../../constants';
import { FolderSchema, NoteSchema } from './schema';

export type Folder = z.infer<typeof FolderSchema>;
export type FolderRecord = Folder & DynamoRecord;
export type FolderItem = Folder & { folderId: string };

export type Note = z.infer<typeof NoteSchema>;
export type NoteRecord = Note & DynamoRecord;
export type NoteItem = Note & { noteId: string; folderId: string };
