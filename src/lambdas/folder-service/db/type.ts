import { z } from 'zod';
import { DynamoRecord } from '../../../constants';
import { FolderSchema } from './schema';

export type Folder = z.infer<typeof FolderSchema>;
export type FolderRecord = Folder & DynamoRecord;
export type FolderItem = Folder & { folderId: string };
